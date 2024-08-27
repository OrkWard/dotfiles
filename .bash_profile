echo $PATH | sed 's/:/\n/g'
[ -f ~/.profile ] && . $HOME/.profile
[ -f ~/.bashrc ] && . $HOME/.bashrc
