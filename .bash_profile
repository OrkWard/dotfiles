export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state
export XDG_CACHE_HOME=$HOME/.cache

export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.local/scripts:$PATH"

# rust
export PATH=$HOME/.cargo/bin:$PATH

# go
export GOPATH=~/.gopath
export PATH=$GOPATH/bin:$PATH

# deno
export DENO_INSTALL=~/.deno
export PATH=$DENO_INSTALL/bin:$PATH

if [ -n $BASH_VERSION ]; then
  . $HOME/.bashrc
fi
