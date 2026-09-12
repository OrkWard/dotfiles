# Track running foreground commands per pane, not in Fish's shared history.
status is-interactive; or return
set -q TMUX TMUX_PANE; or return

function __tmux_state_preexec --on-event fish_preexec
    command tmux set-option -p -t "$TMUX_PANE" @last-command "$argv[1]" 2>/dev/null
end

function __tmux_state_postexec --on-event fish_postexec
    command tmux set-option -pu -t "$TMUX_PANE" @last-command 2>/dev/null
end

# Restore through Fish's input API, never send-keys/Enter or eval. This also
# handles multiline commands safely and waits until the shell is ready.
function __tmux_state_prompt --on-event fish_prompt
    set -q TMUX_RESTORE_COMMAND; or return
    set -l restored "$(string unescape --style=url -- "$TMUX_RESTORE_COMMAND")"
    set -e TMUX_RESTORE_COMMAND
    commandline --replace -- "$restored"
end
