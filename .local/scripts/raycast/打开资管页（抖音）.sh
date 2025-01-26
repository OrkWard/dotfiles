#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title 打开资管页（抖音）
# @raycast.mode silent

# Optional parameters:
# @raycast.icon https://lf1-fe.ecombdstatic.com/obj/eden-cn/upqphj/homepage/icon.svg

# Documentation:
# @raycast.author orkward
# @raycast.authorURL https://raycast.com/orkward

cd ~/Repos/h5
export PATH=~/.local/bin/:$PATH
mise exec node@20 -- spm openurl --schema "snssdk1128://webview?url=https%3A%2F%2Flianmeng.snssdk.com%2Fh5%2F_daren%2Faccount%2Fmanage"

