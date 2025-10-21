#!/usr/bin/env fish
set projects $(tmuxinator list -n 2>/dev/null | tail -n +2)

if test -z "$projects"
  tmux display-message "No tmuxinator projects found"
  exit 1
end

if test "$argv[1]" != "-n"
  set prompt "Switch to project: "
else
  set prompt "Open project: "
end

set selected $(string join \n $projects | fzf --tmux center,80%,60%,border-native \
  --prompt=$prompt \
  --preview 'highlight -O ansi ~/.config/tmuxinator/{}.yml 2>/dev/null || echo "No config file"' \
  --preview-border=sharp \
  --preview-window=right:50%)

if test -n "$selected"
  set current_session $(tmux display-message -p '#S')

  tmuxinator start $selected --no-attach &>/dev/null

  tmux switch-client -t $selected 2>/dev/null

  if test $current_session != $selected -a $argv[1] != -n
    tmux kill-session -t $current_session 2>/dev/null
  end
end
