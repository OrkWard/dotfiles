#!/usr/bin/env bash

port="${1:-7890}"
if ! [[ $port -ge 1024 && $port -le 65535 ]]; then
  echo "Error: $port is not a valid port number"
  exit 1
fi

echo "Set Wi-Fi proxy to localhost:${port}"

networksetup -setwebproxystate "Wi-Fi" on
networksetup -setwebproxy "Wi-Fi" "localhost" $port
networksetup -setsecurewebproxystate "Wi-Fi" on
networksetup -setsecurewebproxy "Wi-Fi" "localhost" $port
networksetup -setsocksfirewallproxystate "Wi-Fi" on
networksetup -setsocksfirewallproxy "Wi-Fi" "localhost" $port
