# atuin
if not type -q atuin
  echo "atuin not found"
else
  atuin init fish | sed 's/-k up/up/' | source
end

# direnv
if not type -q direnv
  echo "direnv not found"
else
  direnv hook fish | source
end

# asdf
if not type -q asdf
  echo "asdf not found"
end
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
if not type -q lua; or not type -q czmod
  echo "z.lua deps not complete"
else
  z.lua --init fish | source
  function _zlua_precmd --on-event fish_prompt
      czmod --add "$PWD" 2> /dev/null &
  end
  abbr jb "j -b"
end

