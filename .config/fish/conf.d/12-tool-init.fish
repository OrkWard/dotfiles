# atuin
if not type -q atuin
    echo "atuin not found"
else
    atuin init fish | sed 's/-k up/up/' | source
end

# zoxide
zoxide init --cmd j fish | source
