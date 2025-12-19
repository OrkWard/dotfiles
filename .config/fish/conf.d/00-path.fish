# local bin
fish_add_path $HOME/.local/bin

# homebrew
if test $(uname -s) = Darwin
    eval $(/opt/homebrew/bin/brew shellenv)
    set -gx HOMEBREW_NO_ENV_HINTS 1
end

# rustup
if test $(uname -s) = Darwin
    fish_add_path --move $(brew --prefix rustup)/bin
end
