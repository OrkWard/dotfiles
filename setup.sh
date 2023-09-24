#!/bin/sh

WORKDIR="$(realpath "$(dirname "$0")")"

# bash
rm $HOME/.bashrc
ln -s $WORKDIR/.bashrc $HOME/.bashrc

# secret
if [ ! -f $HOME/.secrets.env ]; then
    ln -s $WORKDIR/.secrets.env $HOME/.secrets.env
fi

# vim
rm $HOME/.vimrc
ln -s $WORKDIR/.vimrc $HOME/.vimrc

if [ -d $HOME/.vim/autoload ]; then
    rm -r $HOME/.vim/autoload
fi

mkdir -p $HOME/.vim
ln -s $WORKDIR/autoload $HOME/.vim/autoload
