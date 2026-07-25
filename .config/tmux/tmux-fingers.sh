if ! command -v tmux-fingers >/dev/null 2>&1; then
  tmux display-message "tmux-fingers binary not found in PATH"
  exit 1
fi

if [[ "$TERM" == "dumb" ]]; then
  FINGERS_TERM="$(tmux show-option -gqv default-terminal)"
else
  FINGERS_TERM="$TERM"
fi

tmux run-shell "TERM=$FINGERS_TERM tmux-fingers load-config"
