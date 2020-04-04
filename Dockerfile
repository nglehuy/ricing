FROM archlinux:latest

WORKDIR /root

# Setup
RUN mkdir /root/riarch
COPY . /root/riarch
RUN bash /root/riarch/dev.sh
RUN bash /root/riarch/setup.sh

USER root

CMD ["/bin/cat"]
