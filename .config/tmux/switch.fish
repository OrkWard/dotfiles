#!/usr/bin/env fish -N

# p: windows in this session; t: all sessions/windows/panes; s: sessions.
if test "$argv[1]" = preview
    switch "$argv[2]"
        case session
            tmux list-windows -t "$argv[3]" -F '#{?window_active,*, } #{window_index}: #{window_name} (#{window_panes} panes)'
        case '*'
            tmux capture-pane -ep -t "$argv[3]"
    end
    exit
end

set -l mode "$argv[1]"
contains -- "$mode" p t s; or exit 2
set -l origin "$argv[2]"
set -l client "$argv[3]"
set -l current (tmux display-message -p -t "$origin" '#{session_id}')
or exit 1

function candidates --argument-names mode current
    for session in (tmux list-sessions -F '#{session_id}')
        if test "$mode" = p; and test "$session" != "$current"
            continue
        end
        if test "$mode" != p
            tmux display-message -p -t "$session" 'session	#{session_id}	#{session_name} (#{session_windows} windows)'
        end
        if test "$mode" = s
            continue
        end
        for window in (tmux list-windows -t "$session" -F '#{window_id}')
            tmux display-message -p -t "$session:$window" 'window	#{session_id}:#{window_id}	  #{window_index}: #{window_name} (#{window_panes} panes)'
            if test "$mode" = t
                tmux list-panes -t "$session:$window" -F 'pane	#{session_id}:#{window_id}.#{pane_id}	    #{pane_index}: #{pane_current_command} — #{pane_current_path}'
            end
        end
    end
end

set -l prompt 'Switch session: '
test "$mode" = p; and set prompt 'Switch window: '
test "$mode" = t; and set prompt 'Switch tree: '
set -l script (string escape -- (status filename))
set -l selected (candidates "$mode" "$current" | fzf --tmux center,80%,60%,border-native \
    --delimiter='\t' --with-nth=3.. --no-multi --layout=reverse \
    --prompt="$prompt" \
    --preview="fish -N $script preview {1} {2}" \
    --preview-border=sharp --preview-window=right:50%)
if test -n "$selected"
    set -l target (string split -f 2 \t -- "$selected")
    tmux switch-client -c "$client" -t "$target"
end
