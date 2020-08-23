#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

CONFIG=$HOME/.config/polybar/config
LOG=/tmp/polybar_log

PRIMARY=$(xrandr --query | grep " connected" | grep "primary" | cut -d" " -f1)
OTHERS=$(xrandr --query | grep " connected" | grep -v "primary" | cut -d" " -f1)

MONITOR=$PRIMARY polybar -c $CONFIG -r panel 2> $LOG &
sleep 1

for m in $OTHERS; do
  MONITOR=$m polybar -c $CONFIG -r subpanel 2> $LOG &
done

echo "Bars launched..."
