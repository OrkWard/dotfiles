# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

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
