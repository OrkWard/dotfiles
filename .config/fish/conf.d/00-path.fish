# local bin
fish_add_path $HOME/.local/bin
# local script
fish_add_path $HOME/.local/scripts

# homebrew
if test $(uname -s) = Darwin
    eval $(/opt/homebrew/bin/brew shellenv)
    set -gx HOMEBREW_NO_ENV_HINTS 1
end
