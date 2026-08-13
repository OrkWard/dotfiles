# override vendor
if status is-interactive
    set -e DIRENV_DIFF
    set -e DIRENV_DIR
    set -e DIRENV_FILE
    set -e DIRENV_WATCHES

    direnv hook fish | source
end
