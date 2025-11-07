# shellcheck shell=bash
# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return ;;
esac

# Profile start
# PS4='+ $EPOCHREALTIME\011 '
# exec 3>&2 2>/tmp/bashstart.$$.log
# set -x

# --------------------- Basic ------------------------
export EDITOR=vim
export LS_COLORS=

if [ "$(uname -s)" == "Darwin" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  export HOMEBREW_NO_ENV_HINTS=1
fi

# language
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8 # for mosh on MacOS
export LANG=en_US.UTF-8

# append to the history file, don't overwrite it
shopt -s histappend

# enable extended globbing
shopt -s extglob

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# don't put duplicate lines or lines starting with space in the history.
# remove duplicated lines
export HISTCONTROL=ignoredups:erasedups:ignoreboth
export HISTSIZE=10000
export HISTFILESIZE=20000

# --------------------- color & prompt ---------------------
PS1=''
PS1+='\[\033[32m\]\u '
PS1+='\[\033[34m\]\w '
PS1+='\[\033[33m\][$?] $(date +"%H:%M:%S")'
PS1+='\[\033[0m\]'
PS1+="\n"
PS1+='\[\033]133;A\033\\\]$ '

# ---------------------------- Misc ----------------------------
# custom path for local bin and local script
export PATH="$HOME/.local/bin:$PATH"

# handy
alias rm="rm -r"
alias mkdir="mkdir -p"

# cd
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# vim
alias vn="nvim ~/.config/nvim/init.lua"
alias vb="tmuxinator bash"
alias vv="tmuxinator vim-plug"
alias vg="tmuxinator ghostty"
alias vt="vim ~/.config/tmux/tmux.conf"

# gcc
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# yadm
alias yac='yadm add -u && yadm commit -m "$(date)"'
alias ys='yadm status'
alias yd='yadm diff'
alias yl='yadm pull'
alias yp='yadm push'

# ls
alias l='ls --color'
alias ls='ls --color'
alias ll='ls --color -alh'
alias la='ls --color -a'
alias recent='ls --color -tlh | head'

alias bat="bat --theme=GitHub"
alias serve="caddy file-server . --listen localhost:8080"
alias tree="lsd --tree --depth 2"

# Profile end
# set +x
# exec 2>&3 3>&-
