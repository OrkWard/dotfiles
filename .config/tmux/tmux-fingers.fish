#!/usr/bin/env fish -N

if not type -q tmux-fingers
  tmux display-message "tmux-fingers binary not found in PATH"
  exit 1
end

if test "$TERM" = dumb
  set fingers_term (tmux show-option -gqv default-terminal)
else
  set fingers_term "$TERM"
end

tmux run-shell "TERM=$fingers_term tmux-fingers load-config"
