#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title 打开资管页（抖音）
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 

# Documentation:
# @raycast.author orkward
# @raycast.authorURL https://raycast.com/orkward

cd ~/Repos/h5
export PATH=~/.local/bin/:$PATH
mise exec node@20 -- spm openurl --schema "snssdk1128://webview?url=https%3A%2F%2Flianmeng.snssdk.com%2Fh5%2F_daren%2Faccount%2Fmanage"
echo "tell application \"System Events\" to key code 53" | osascript

