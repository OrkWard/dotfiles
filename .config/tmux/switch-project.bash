#!/usr/bin/env bash

projects=$(tmuxinator list -n 2>/dev/null | tail -n +2)

if [ -z "$projects" ]; then
  tmux display-message "No tmuxinator projects found"
  exit 1
fi

if [[ "$1" != "-n" ]]; then
  prompt="Switch to project: "
else
  prompt="Open project: "
fi

selected=$(echo "$projects" | fzf-tmux -p 80%,60% \
  --prompt="$prompt" \
  --border \
  --preview 'cat ~/.config/tmuxinator/{}.yml 2>/dev/null || echo "No config file"' \
  --preview-window=right:50%)

if [ -n "$selected" ]; then
  current_session=$(tmux display-message -p '#S')

  tmuxinator start "$selected" --no-attach &>/dev/null

  tmux switch-client -t "$selected" 2>/dev/null

  if [[ "$current_session" != "$selected" && "$1" != "-n" ]]; then
    tmux kill-session -t "$current_session" 2>/dev/null
  fi
fi
