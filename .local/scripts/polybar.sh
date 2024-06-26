#!/usr/bin/env bash

# Terminate already running bar instances
polybar-msg cmd quit

echo "---" | tee -a /tmp/polybar.log
polybar 2>&1 | tee -a /tmp/polybar.log & disown

echo "Bars launched..."
