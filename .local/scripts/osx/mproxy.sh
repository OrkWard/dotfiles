#!/usr/bin/env bash

while getopts 's' OPTION; do
  case "$OPTION" in
    s)
      socks="true"
      ;;
    *)
      ;;
  esac
done
shift "$((OPTIND - 1))"

port="${1:-9090}"
if ! [[ "$port" -ge 1024 && $port -le 65535 ]]; then
  echo "Error: $port is not a valid port number"
  exit 1
fi

echo "Set Wi-Fi proxy to localhost:${port}"

networksetup -setwebproxystate "Wi-Fi" on
networksetup -setwebproxy "Wi-Fi" "localhost" "$port"
networksetup -setsecurewebproxystate "Wi-Fi" on
networksetup -setsecurewebproxy "Wi-Fi" "localhost" "$port"
if [ -n "$socks" ]; then
  networksetup -setsocksfirewallproxystate "Wi-Fi" on
  networksetup -setsocksfirewallproxy "Wi-Fi" "localhost" "$port"
fi
