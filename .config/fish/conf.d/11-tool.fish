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
fish_add_path --move $ASDF_DATA_DIR/shims

# bat
set -gx BAT_THEME GitHub

# pnpm
set -gx PNPM_HOME $HOME/.local/share/pnpm
fish_add_path --move $PNPM_HOME

# fzf
function _fzf_pick_file
  set -l result (fzf --query=(commandline -t)); and commandline -rt -- "$result"
  commandline -f repaint
end
bind \ct _fzf_pick_file

# z.lua
set -xg _ZL_CMD j
set -xg _ZL_DATA_DIR $HOME/.local/share/zlua/
set -xg _ZL_DATA $HOME/.local/share/zlua/zlua.txt
if not type -q lua
  echo "lua not found"
else if not type -q czmod
  echo "czmod not found"
else
  z.lua --init fish | source
  function _zlua_precmd --on-event fish_prompt
    czmod --add "$PWD" 2> /dev/null &
  end
end
