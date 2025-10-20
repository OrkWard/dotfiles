# homebrew
if [ $(uname -s) = "Darwin" ]
  eval $(/opt/homebrew/bin/brew shellenv)
  set -x HOMEBREW_NO_ENV_HINTS 1
end

# local bin
set -x PATH $HOME/.local/bin $PATH

# rustup
if [ $(uname -s) = "Darwin" ]
  set -x PATH $(brew --prefix rustup)/bin $PATH
end
