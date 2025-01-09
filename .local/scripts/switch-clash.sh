echo "Pick a config to switch:"
cfiles="$(ls /opt/homebrew/etc/mihomo/*.yaml | grep -v "config.yaml")"

select config in $cfiles; do
  if [ -z "$config" ]; then
    echo "Use the same config."
    exit 0
  fi
  echo "Switch to $config..."
  ln -sf $config /opt/homebrew/etc/mihomo/config.yaml
  brew services restart mihomo
  break
done

if [ ! -z "$?" ]; then
  echo "Use the same config."
fi

