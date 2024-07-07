#!/usr/bin/env bash

# Add this script to your wm startup file.

DIR="$HOME/.config/polybar/"

# Terminate already running bar instances
polybar-msg cmd quit

# wait quit
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch the bar
polybar main -c "$DIR"/config.ini >& /tmp/polybar.log
