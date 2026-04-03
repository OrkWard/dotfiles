# local bin
fish_add_path --path --move $HOME/.local/bin
# local script
fish_add_path --path --move $HOME/.local/scripts

# homebrew
if test $(uname -s) = Darwin
    eval $(/opt/homebrew/bin/brew shellenv)
    set -gx HOMEBREW_NO_ENV_HINTS 1
end
