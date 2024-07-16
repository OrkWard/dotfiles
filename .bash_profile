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
