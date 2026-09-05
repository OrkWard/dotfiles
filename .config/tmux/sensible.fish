#!/usr/bin/env fish -N

function is_osx
    test (uname) = Darwin
end

function iterm_terminal
    string match -rq '^iTerm' -- "$TERM_PROGRAM"; or string match -rq '^iTerm' -- "$LC_TERMINAL"
end

function command_exists
    type -q "$argv[1]"
end

function option_value_not_changed
    test (tmux show-option -gv "$argv[1]") = "$argv[2]"
end

function server_option_value_not_changed
    test (tmux show-option -sv "$argv[1]") = "$argv[2]"
end

function main
    # OPTIONS

    # address vim mode switching delay (http://superuser.com/a/252717/65504)
    if server_option_value_not_changed escape-time 500
        tmux set-option -s escape-time 0
    end

    # increase scrollback buffer size
    if option_value_not_changed history-limit 2000
        tmux set-option -g history-limit 50000
    end

    # tmux messages are displayed for 4 seconds
    if option_value_not_changed display-time 750
        tmux set-option -g display-time 4000
    end

    # refresh 'status-left' and 'status-right' more often
    if option_value_not_changed status-interval 15
        tmux set-option -g status-interval 5
    end

    # required (only) on OS X
    if is_osx; and command_exists reattach-to-user-namespace; and option_value_not_changed default-command ''
        tmux set-option -g default-command "reattach-to-user-namespace -l $SHELL"
    end

    # upgrade $TERM, tmux 1.9
    if option_value_not_changed default-terminal screen
        tmux set-option -g default-terminal screen-256color
    end
    # upgrade $TERM, tmux 2.0+
    if server_option_value_not_changed default-terminal screen
        tmux set-option -s default-terminal screen-256color
    end

    # emacs key bindings in tmux command prompt (prefix + :) are better than
    # vi keys, even for vim users
    tmux set-option -g status-keys emacs
    # focus events enabled for terminals that support them
    tmux set-option -g focus-events on

    # super useful when using "grouped sessions" and multi-monitor setup
    if not iterm_terminal
        tmux set-window-option -g aggressive-resize on
    end

end

main
