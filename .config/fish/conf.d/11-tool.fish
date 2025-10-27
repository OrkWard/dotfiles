# atuin
atuin init fish | sed 's/-k up/up/' | source

# direnv
direnv hook fish | source

# asdf
set -gx ASDF_CONFIG_FILE $HOME/.config/asdf/asdfrc
set -gx ASDF_DATA_DIR $HOME/.local/state/asdf
fish_add_path $ASDF_DATA_DIR/shims

# corepack
set -gx COREPACK_ENABLE_AUTO_PIN 0
set -gx COREPACK_ENABLE_DOWNLOAD_PROMPT 1

# pnpm
set -gx PNPM_HOME $HOME/.local/share/pnpm
fish_add_path $PNPM_HOME

# z.lua
set -xg _ZL_CMD j
set -xg _ZL_DATA_DIR $HOME/.local/share/zlua/
set -xg _ZL_DATA $HOME/.local/share/zlua/zlua.txt
lua $HOME/.local/bin/z.lua --init fish | source

abbr zb "z -b"
