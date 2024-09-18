#!/bin/bash

if ! pgrep -x "KeyboardHolder" > /dev/null
then
    osascript -e 'display notification "KeyboardHolder is not running!" with title "Alert"'
fi
