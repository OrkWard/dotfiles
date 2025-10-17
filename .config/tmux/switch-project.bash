#!/usr/bin/env bash

# readarray -t projects < <(tmuxinator list -n 2>/dev/null | tail -n +2)
projects=$(tmuxinator list -n 2>/dev/null | tail -n +2)

if [ -z "$projects" ]; then
  tmux display-message "No tmuxinator projects found"
  exit 1
fi

selected=$(echo "$projects" | fzf-tmux -p 80%,60% \
  --prompt="Switch to project: " \
  --border \
  --preview 'cat ~/.config/tmuxinator/{}.yml 2>/dev/null || echo "No config file"' \
  --preview-window=right:50%)

if [ -n "$selected" ]; then
  current_session=$(tmux display-message -p '#S')

  tmuxinator start "$selected" -n "$selected" &>/dev/null &

  sleep 0.3

  tmux switch-client -t "$selected" 2>/dev/null

  if [ "$current_session" != "$selected" ]; then
    tmux kill-session -t "$current_session" 2>/dev/null
  fi
fi
