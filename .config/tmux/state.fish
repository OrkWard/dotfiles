#!/usr/bin/env fish -N
# Independent, structure-only save/restore inspired by tmux-resurrect.
# Snapshot fields are URL-encoded data, never executable shell source.

function fail
    printf 'tmux-state: %s\n' "$argv" >&2
    tmux display-message "tmux-state: $argv" 2>/dev/null
    exit 1
end

function run
    command tmux $argv; or fail "tmux $argv failed (partial restore may remain)"
end

function value --argument-names target format
    command tmux display-message -p -t "$target" "$format"; or fail 'Could not read tmux state'
end

function record
    set -l fields
    for field in $argv
        # Prefix keeps empty fields intact through command substitution.
        set -a fields x(string escape --style=url -- "$field")
    end
    string join \t -- $fields
end

function decode --argument-names line
    set -g row
    for field in (string split \t -- "$line")
        string match -rq '^x([A-Za-z0-9_~./-]|%[0-9A-Fa-f]{2})*$' -- "$field"; or fail 'Invalid snapshot encoding'
        set -a row "$(string unescape --style=url -- (string sub -s 2 -- "$field"))"
    end
end

function last_command --argument-names pane
    set -l saved (tmux show-options -pqv -t "$pane" @last-command | string collect)
    if test -n "$saved"
        printf '%s\n' "$saved"
        return
    end
    # Best effort for shells which have not loaded the preexec hook yet.
    # ps loses original shell quoting/pipelines; never execute this result.
    set -l tty (value "$pane" '#{pane_tty}')
    set -l shell_pid (value "$pane" '#{pane_pid}')
    set -l current (value "$pane" '#{pane_current_command}')
    for process in (ps -ww -t (string replace '/dev/' '' -- "$tty") -o pid=,pgid=,tpgid=,command= 2>/dev/null)
        set -l parts (string match -r '^\s*(\d+)\s+(\d+)\s+(-?\d+)\s+(.*)$' -- "$process")
        test (count $parts) -eq 5; or continue
        test "$parts[2]" = "$parts[4]"; or continue
        if test "$parts[2]" = "$shell_pid"; and contains -- "$current" fish bash zsh sh dash ksh
            continue
        end
        printf '%s\n' "$parts[5]"
        return
    end
end

function save_state
    record version 1
    set -l sessions (tmux list-sessions -F '#{session_id}')
    test (count $sessions) -gt 0; or fail 'No sessions to save'
    set -l seen
    for session in $sessions
        record session "$session" "$(value "$session" '#{session_name}')" \
            (value "$session" '#{window_index}') \
            "$(tmux list-windows -t "$session" -f '#{window_last_flag}' -F '#{window_index}')" \
            (tmux show-options -Av -t "$session" renumber-windows)
        for window in (tmux list-windows -t "$session" -F '#{window_id}')
            set -l target "$session:$window"
            record window "$session" "$window" (value "$target" '#{window_index}') \
                "$(value "$target" '#{window_name}')" \
                (value "$target" '#{window_layout}') (value "$target" '#{window_width}') \
                (value "$target" '#{window_height}') (value "$target" '#{pane_id}') \
                (value "$target" '#{window_zoomed_flag}') \
                (tmux show-options -Awv -t "$target" automatic-rename) \
                (tmux show-options -Awv -t "$target" pane-base-index) \
                (tmux show-options -Awv -t "$target" window-size)
            contains -- "$window" $seen; and continue
            set -a seen "$window"
            for pane in (tmux list-panes -t "$target" -F '#{pane_id}')
                record pane "$window" "$pane" \
                    "$(value "$pane" '#{pane_current_path}')" \
                    "$(value "$pane" '#{pane_title}')" \
                    "$(last_command "$pane")"
            end
        end
    end
    if test -n "$client"
        record client "$(tmux display-message -p -c "$client" '#{client_session}')"
    end
end

function directory --argument-names dir
    if test -d "$dir"
        printf '%s\n' "$dir"
    else
        printf 'tmux-state: missing directory %s; using HOME\n' "$dir" >&2
        printf '%s\n' "$HOME"
    end
end

function validate_snapshot
    test "$argv[1]" = (record version 1); or fail 'Unsupported snapshot'
    # Validate all records before publishing or creating anything.
    for line in $argv
        decode "$line"
        set -l expected 0
        switch "$row[1]"
            case version client
                set expected 2
            case session pane
                set expected 6
            case window
                set expected 13
            case '*'
                fail 'Unknown snapshot record'
        end
        test (count $row) -eq "$expected"; or fail 'Incomplete snapshot record'
        if test "$row[1]" = window
            for index in 4 7 8 10 12
                string match -rq '^[0-9]+$' -- "$row[$index]"; or fail 'Invalid window metadata'
            end
        end
    end
end

function restore_state
    test -f "$state_dir/last"; or fail 'No saved snapshot'
    set -l lines
    while read -l line
        set -a lines "$line"
    end <"$state_dir/last"
    validate_snapshot $lines

    set -l old_windows
    set -l new_windows
    set -l restored 0
    set -l skipped 0
    for line in $lines
        decode "$line"
        test "$row[1]" = session; or continue
        set -l session $row
        if tmux has-session -t "=$session[3]" 2>/dev/null
            set skipped (math $skipped + 1)
            continue
        end
        # A detached placeholder avoids clobbering a saved window index.
        set -l sid (run new-session -dP -F '#{session_id}' -s "$session[3]" -x 240 -y 80 -n restore-placeholder (status fish-path) -N -i)
        run set-option -t "$sid" renumber-windows off
        set -l placeholder (value "$sid" '#{window_id}')
        set -l completed_windows
        set -l window_sizes
        for window_line in $lines
            decode "$window_line"
            test "$row[1]" = window; and test "$row[2]" = "$session[2]"; or continue
            set -l window $row
            # Move the placeholder out of the way, without window renumbering.
            if test (value "$placeholder" '#{window_index}') = "$window[4]"
                run move-window -s "$placeholder" -t "$sid:"
            end
            set -l linked (contains -i -- "$window[3]" $old_windows)
            if test -n "$linked"
                run link-window -d -s "$new_windows[$linked]" -t "$sid:$window[4]"
                continue
            end
            set -l wid
            set -l active_pane
            for pane_line in $lines
                decode "$pane_line"
                test "$row[1]" = pane; and test "$row[2]" = "$window[3]"; or continue
                set -l pane $row
                set -l cwd (directory "$pane[4]" | string collect)
                set -l command_env TMUX_RESTORE_COMMAND=(string escape --style=url -- "$pane[6]")
                set -l pid
                if test -z "$wid"
                    set pid (run new-window -dP -F '#{pane_id}' -t "$sid:$window[4]" \
                        -c "$cwd" -n "$window[5]" -e "$command_env" (status fish-path) -i)
                    set wid (value "$pid" '#{window_id}')
                    run set-option -w -t "$wid" automatic-rename off
                    run set-option -w -t "$wid" pane-base-index "$window[12]"
                    run resize-window -t "$wid" -x "$window[7]" -y "$window[8]"
                else
                    # Rebalance between splits so even many panes can be created.
                    run select-layout -t "$wid" tiled >/dev/null
                    set pid (run split-window -dP -F '#{pane_id}' -t "$wid" -c "$cwd" \
                        -e "$command_env" (status fish-path) -i)
                end
                run select-pane -t "$pid" -T "$pane[5]"
                test "$pane[3]" = "$window[9]"; and set active_pane "$pid"
            end
            test -n "$wid"; or fail 'Window has no saved panes'
            run select-layout -t "$wid" "$window[6]" >/dev/null
            test -z "$active_pane"; or run select-pane -t "$active_pane"
            test "$window[10]" != 1; or run resize-pane -Z -t "$wid"
            run rename-window -t "$wid" "$window[5]"
            run set-option -w -t "$wid" automatic-rename "$window[11]"
            set -a completed_windows "$wid"
            set -a window_sizes "$window[13]"
            set -a old_windows "$window[3]"
            set -a new_windows "$wid"
        end
        # Only remove the placeholder after at least one window was restored.
        test (count (tmux list-windows -t "$sid" -F '#{window_id}')) -gt 1; or fail 'Session has no saved windows'
        run kill-window -t "$placeholder"
        test -z "$session[5]"; or run select-window -t "$sid:$session[5]"
        run select-window -t "$sid:$session[4]"
        run set-option -t "$sid" renumber-windows "$session[6]"
        for index in (seq (count $completed_windows))
            run set-option -w -t "$completed_windows[$index]" window-size "$window_sizes[$index]"
        end
        set restored (math $restored + 1)
    end
    if test -n "$client"
        for line in $lines
            decode "$line"
            if test "$row[1]" = client; and test -n "$row[2]"
                run switch-client -c "$client" -t "=$row[2]"
            end
        end
    end
    tmux display-message "Restored $restored sessions; skipped $skipped existing sessions"
end

contains -- "$argv[1]" save restore; or fail 'Usage: state.fish save|restore [client]'
set -g client "$argv[2]"
set -g state_dir "$HOME/.local/state/tmux"
set -q XDG_STATE_HOME; and set state_dir "$XDG_STATE_HOME/tmux"
set -q TMUX_STATE_DIR; and set state_dir "$TMUX_STATE_DIR"
umask 077
mkdir -p "$state_dir"; or fail 'Cannot create state directory'
mkdir "$state_dir/.lock" 2>/dev/null; or fail 'Save/restore already running (or stale .lock directory)'
function cleanup --on-event fish_exit
    set -q temporary; and rm -f -- "$temporary"
    rmdir "$state_dir/.lock"
end

switch "$argv[1]"
    case save
        set -g temporary (mktemp "$state_dir/.save.XXXXXX"); or fail 'Cannot create snapshot'
        save_state >"$temporary"; or fail 'Save failed'
        set -l lines
        while read -l line
            set -a lines "$line"
        end <"$temporary"
        validate_snapshot $lines
        mv -f -- "$temporary" "$state_dir/last"; or fail 'Cannot publish snapshot'
        tmux display-message 'Tmux structure and last commands saved'
    case restore
        restore_state
end
