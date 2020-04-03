#!/usr/bin/env sh

YAD_WIDTH=350
YAD_HEIGHT=100

case "$1" in
--popup)
    if [ "$(xdotool getwindowfocus getwindowname)" = "yad-powermenu" ]; then
        kill $(xdotool search --name "yad-powermenu" getwindowpid)
        exit 0
    fi
    
    yad --width=$YAD_WIDTH --height=$YAD_HEIGHT --center --skip-taskbar \
      --title="yad-powermenu" --close-on-unfocus --fixed --undecorated \
      --form --colums=1 --seperator=" " --align=center --no-buttons \
      --field="Reboot:FBTN" "notify-send Reboot" \
      --field="Shutdown:FBTN" "notify-send Shutdown" \
      --field="Hibernate:FBTN" "notify-send Hibernate" \
      --field="Logout:FBTN" "notify-send Logout" \
      >/dev/null &
    ;;
*)
    echo "Powermenu"
    ;;
esac
