# atuin
if not type -q atuin
    echo "atuin not found"
else
    atuin init fish | sed 's/-k up/up/' | source
end

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
        czmod --add "$PWD" 2>/dev/null &
    end
end
