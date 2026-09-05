#!/usr/bin/env fish -N

if test "$argv[1]" = -n
    set -l projects
    for project in ~/.config/tmuxinator/*
        set -a projects (path basename "$project")
    end

    if test (count $projects) -eq 0
        tmux display-message 'No tmuxinator projects found'
        exit 1
    end

    set -l selected (string join \n $projects | fzf --tmux center,80%,60%,border-native \
        --prompt='Open project: ' \
        --preview 'highlight -O ansi ~/.config/tmuxinator/{} 2>/dev/null || echo "No config file"' \
        --preview-border=sharp \
        --preview-window=right:50% | string replace --regex '\\.[^.]*$' '')

    if test -n "$selected"
        tmuxinator start "$selected" --no-attach &>/dev/null
        tmux switch-client -t "$selected" 2>/dev/null
    end
    exit
end

set -l sessions
for session_id in (tmux list-sessions -F '#{session_id}' 2>/dev/null)
    set -l session_name (tmux display-message -p -t "$session_id" '#{session_name}')
    set -l windows (tmux list-windows -t "$session_id" -F '#{window_name}' | string join ',')
    set -a sessions (printf '%s\t%s (%s) [%s]' "$session_id" "$session_name" "$session_id" "$windows")
end

if test (count $sessions) -eq 0
    tmux display-message 'No tmux sessions found'
    exit 1
end

set -l selected (printf '%s\n' $sessions | fzf --tmux center,80%,60%,border-native \
    --delimiter='\t' \
    --with-nth=2.. \
    --prompt='Switch to session: ' \
    --preview "tmux list-windows -t {1} -F '#{?window_active,*, } #{window_index}: #{window_name} (#{window_panes} panes)'" \
    --preview-border=sharp \
    --preview-window=right:50%)

if test -n "$selected"
    set -l target (string split -f 1 \t -- "$selected")
    tmux switch-client -t "$target"
end
