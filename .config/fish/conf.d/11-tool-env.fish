# go
set -gx GOPATH $HOME/.go

# gcc
set -gx GCC_COLORS 'error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

if [ "$TERM_PROGRAM" = zed ]
    set -gx EDITOR "zed -w"
end

# bat
set -gx BAT_THEME GitHub

# fzf
function _fzf_pick_file
    set -l result (fzf --query=(commandline -t)); and commandline -rt -- "$result"
    commandline -f repaint
end
set -gx FZF_DEFAULT_OPTS "--color light --color 'fg+:red,bg+:-1' --pointer '' \
  --bind 'ctrl-d:preview-page-down' \
  --bind 'ctrl-u:preview-page-up' \
  --bind 'ctrl-/:toggle-preview'"
bind \ct _fzf_pick_file

# asdf
if not type -q asdf
    echo "asdf not found"
end
set -gx ASDF_CONFIG_FILE $HOME/.config/asdf/asdfrc
set -gx ASDF_DATA_DIR $HOME/.local/state/asdf
fish_add_path --move $ASDF_DATA_DIR/shims

# pnpm
set -gx PNPM_HOME $HOME/.local/share/pnpm
fish_add_path --move $PNPM_HOME
