#!/usr/bin/env sh

case "$1" in
--popup)
    if [ "$(xdotool getwindowfocus getwindowname)" = "yad-powermenu" ]; then
        kill $(xdotool search --name "yad-powermenu" getwindowpid)
        exit 0
    fi
    
    yad --width=0 --height=0 --center --skip-taskbar \
      --title="yad-powermenu" --close-on-unfocus --fixed --undecorated \
      --text="POWERMENU OPTIONS" --text-align=center \
      --form --columes=4 --align=center --no-buttons \
      --field="Reboot:FBTN" "systemctl reboot" \
      --field="Shutdown:FBTN" "systemctl poweroff" \
      --field="Hibernate:FBTN" "systemctl hibernate" \
      --field="Suspend:FBTN" "systemctl suspend" \
      --field="Logout:FBTN" "bspc quit" \
      >/dev/null &
    ;;
*)
    echo "Powermenu"
    ;;
esac
