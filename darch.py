import argparse
import os
import sys
import subprocess
import docker
import platform
from functools import reduce

DEFAULT_IMAGE_TAG = "lordh9072/darch:latest"
DEFAULT_CONTAINER = "darch"
DEFAULT_WORKSPACE = "/root"
EXEC_FORMAT = 'docker exec --workdir \"{}\" -it {} zsh {}'
PLATFORM = platform.system()

if PLATFORM == "Windows":
    import win32api

try:
    client = docker.from_env()
except BaseException:
    print('No docker installed')
    print('Cannot connect to docker, has docker run?')
    exit()

if PLATFORM == 'Windows':
    drives_list = win32api.GetLogicalDriveStrings().split('\\\x00')[:-1]
    # Default for sharing all drives
    drives = list(map(lambda d: {
        f'{d}//': {'bind': f'{DEFAULT_WORKSPACE}/drives/{d[0].lower()}', 'mode': 'rw'}
    }, drives_list))
    drives = reduce(lambda acc, item: {**acc, **item}, drives, {})
    volumes = drives

    def process_cwd(d):
        if '~' == d[0]:
            return f'{DEFAULT_WORKSPACE}{d[1:]}'
        d = os.path.abspath(d)
        d = d.replace('\\', '/')
        for drive in drives_list:
            drive_name = f'{drive}/'
            if drive_name in d:
                return d.replace(drive_name, f'{DEFAULT_WORKSPACE}/drives/{drive_name.lower()[0]}/')
        return DEFAULT_WORKSPACE

else:  # Linux and MacOS
    volumes = {
        '/': {'bind': f'{DEFAULT_WORKSPACE}/drives', 'mode': 'rw'}
    }

    def process_cwd(d):
        if '~' == d[0]:
            return f'{DEFAULT_WORKSPACE}{d[1:]}'
        d = os.path.abspath(d)
        return f'{DEFAULT_WORKSPACE}/drives{d}'


parser = argparse.ArgumentParser(description='Darch full command flags')
parser.add_argument('cmd', metavar='cmd', nargs='*',
                    help="command and arguments")
parser.add_argument('--workdir', '-w', type=str,
                    help="Where to operate this command, default to current directory")
parser.add_argument('--detach', '-d',
                    action='store_true', help="Start in detach mode")
parser.add_argument('--image', '-i', type=str,
                    default=DEFAULT_IMAGE_TAG, help="Docker image tag")
parser.add_argument('--container', '-c', type=str,
                    default=DEFAULT_CONTAINER, help="Docker container name")
args = parser.parse_args()

if args.workdir is None:
    docker_dir = process_cwd(os.getcwd())
else:
    docker_dir = process_cwd(args.workdir)

image_tag = args.image
container_name = args.container

IMAGE_EXIST = False
for image in client.images.list():
    for tag in image.tags:
        if image_tag in tag:
            IMAGE_EXIST = True
            break
    if IMAGE_EXIST:
        break

if not IMAGE_EXIST:
    print("Pulling image ...")
    client.images.pull(image_tag)

CONTAINER_EXIST = False
for container in client.containers.list():
    if container_name == container.name:
        CONTAINER_EXIST = True
        break

if not CONTAINER_EXIST:
    config = {
        'image': image_tag,
        'command': '/bin/cat',
        'name': container_name,
        'volumes': {
            **volumes
        },
        'network': 'bridge',
        'working_dir': DEFAULT_WORKSPACE,
        'restart_policy': {
            'Name': 'always'
        },
        'tty': True,
        'detach': True,
        'ports': {
            3000:3000,
            4000:4000,
            5000:5000,
            8080:8080,
            80:80,
        }
    }
    client.containers.run(**config)

if args.cmd:
    cmd = EXEC_FORMAT.format(docker_dir, container_name,
                             '-ilc \"{}\"'.format(' '.join(args.cmd)))
else:
    cmd = EXEC_FORMAT.format(docker_dir, container_name, "")

print('detach: {} -- {}'.format(args.detach, cmd))
if args.detach is True:
    subprocess.Popen(cmd, stdin=None, stdout=None,
                     stderr=None, close_fds=True, shell=False)
else:
    subprocess.call(cmd, shell=True)
