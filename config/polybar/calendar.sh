#!/bin/sh

YAD_WIDTH=222  # 222 is minimum possible value
YAD_HEIGHT=193 # 193 is minimum possible value
DATE="$(date +"%x")"
TOP=true

case "$1" in
--popup)
    if [ "$(xdotool getwindowfocus getwindowname)" = "yad-calendar" ]; then
        kill $(xdotool search --name "yad-calendar" getwindowpid)
        exit 0
    fi

    eval "$(xdotool getmouselocation --shell)"
    eval "$(xdotool getdisplaygeometry --shell)"

    # X
    : $((pos_x = X - YAD_WIDTH / 2))

    # Y
    if [ "$TOP" = true ]; then
        : $((pos_y = 27 + 5 + 5))
    else
        : $((pos_y = HEIGHT - YAD_HEIGHT - 27 - 5 - 5))
    fi

    yad --calendar --show-weeks --undecorated --fixed --close-on-unfocus --no-buttons \
        --width=$YAD_WIDTH --height=$YAD_HEIGHT --posx=$pos_x --posy=$pos_y \
        --title="yad-calendar" --borders=0 >/dev/null &
    ;;
*)
    echo "$DATE"
    ;;
esac
