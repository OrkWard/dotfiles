# atuin
atuin init fish | sed 's/-k up/up/' | source

# direnv
direnv hook fish | source

# asdf
set -gx ASDF_CONFIG_FILE $HOME/.config/asdf/asdfrc
set -gx ASDF_DATA_DIR $HOME/.local/state/asdf
fish_add_path $ASDF_DATA_DIR/shims

# autojump
if [ $(uname -s) = "Darwin" ]
  [ -f /opt/homebrew/share/autojump/autojump.fish ] && . /opt/homebrew/share/autojump/autojump.fish
end

# corepack
set -gx COREPACK_ENABLE_AUTO_PIN 0
set -gx COREPACK_ENABLE_DOWNLOAD_PROMPT 1

# pnpm
set -gx PNPM_HOME $HOME/.local/share/pnpm
fish_add_path $PNPM_HOME

