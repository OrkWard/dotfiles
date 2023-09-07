#!/bin/sh

WORKDIR="$(realpath "$(dirname "$0")")"

# bash
rm $HOME/.bashrc
ln -s $WORKDIR/.bashrc $HOME/.bashrc

# secret
if [ ! -f $HOME/.secret ]; then
    ln -s $WORKDIR/.secret.env $HOME/.secret.env
fi

# vim
rm $HOME/.vimrc
ln -s $WORKDIR/.vimrc $HOME/.vimrc

if [ -d $HOME/.vim/autoload ]; then
    rm -r $HOME/.vim/autoload
fi

mkdir -p $HOME/.vim
ln -s $WORKDIR/autoload $HOME/.vim/autoload
