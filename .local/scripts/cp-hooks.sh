#!/usr/bin/env bash

function is_git_directory {
    git rev-parse --is-inside-work-tree > /dev/null 2>&1
    return $?
}

function get_local_hooks_path {
    git config core.hooksPath
}

function get_global_hooks_path {
    git config --global core.hooksPath
}

if is_git_directory; then
    local_hooks_path=$(get_local_hooks_path)
    eval global_hooks_path=$(get_global_hooks_path)

    if [ -z "$local_hooks_path" ]; then
        local_hooks_path=".git/hooks"
    fi

    if [ -z "$global_hooks_path" ]; then
        echo "Global core.hooksPath is not set."
        exit 1
    fi

    exit_code=0

    for hook in "$global_hooks_path"/*; do
        if [ -f "$hook" ]; then
            cp "$hook" "$local_hooks_path" 2>/dev/null
            if [ $? -ne 0 ]; then
                echo "Warning: Failed to copy $hook. Ignoring this file for now."
                exit_code=1
            fi
        fi
    done

    exit $exit_code
else
    echo "Not inside a git directory."
    exit 1
fi

