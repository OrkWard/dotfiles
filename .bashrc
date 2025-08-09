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

if [ $(uname -s) == "Darwin" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
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

# remove mail check
unset MAILCHECK

# --------------------- color & prompt ---------------------
PS1=''
PS1+='\[\033[32m\]\u '
PS1+='\[\033[34m\]\w '
PS1+='\[\033[35m\]$(__git_ps1 "(%s) ")'
PS1+='\[\033[33m\][$?] $(date +"%H:%M:%S")'
PS1+='\[\033[0m\]'
PS1+="\n"
PS1+='\[\033]133;A\033\\\]$ '

# ---------------------- Applications ----------------------
config_dir=$XDG_CONFIG_HOME/bash

load_module() {
  plugin="$config_dir/$1"
  if [ -f "$plugin.bash" ]; then
    . $plugin.bash
  elif [ -d $plugin ]; then
    for plug_component in "$plugin"/*.bash; do
      if [ -f "$plug_component" ] && [ "$plug_component" != "$plugin/config.bash" ]; then
        . "$plug_component"
      fi
    done

    # always source config last
    if [ -f "$plugin/config.bash" ]; then
      . "$plugin/config.bash"
    fi
  fi
}

load_module local
load_module ni
load_module less
load_module git
load_module fzf
# load_module complete-alias
load_module autojump
load_module bash-preexec
load_module broot
load_module lf
load_module tailscale
load_module pnpm

# ---------------------------- Misc ------------------------------
# custom path for local bin and local script
export PATH="$HOME/.local/bin:$HOME/.local/scripts:$PATH"

# keybinding
bind -x '"\C-t":vifm'

# local secret
[ -f "$HOME/.env" ] && source "$HOME/.env"

# handy
alias rm="rm -r"
alias mkdir="mkdir -p"

# default workdir
export D="$HOME/Desktop"

# go
export GOPATH="$HOME/.go"

# rustup
if [ $(uname -s) == "Darwin" ]; then
  export PATH="$(brew --prefix rustup)/bin:$PATH"
fi

# asdf
export ASDF_CONFIG_FILE="$HOME/.config/asdf/asdfrc"
export ASDF_DATA_DIR="$HOME/.local/state/asdf"
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# atuin
eval "$(atuin init bash)"

# cd
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# vim
alias vb="cd ~/.config/bash && vim ~/.bashrc && cd -"
alias vv="vim ~/.config/vim/vimrc"
alias vh="nvim ~/.hammerspoon/init.lua"
alias va="vim ~/.config/alacritty/alacritty.toml"
alias vn="nvim ~/.config/nvim/init.lua"
alias vt="vim ~/.config/tmux/tmux.conf"
alias v3="vim ~/.config/i3/config"

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

alias bat="bat --theme=GitHub"
alias serve="caddy file-server . --listen localhost:8080"
alias tree="lsd --tree --depth 2"

# acme.sh
[ -f ~/.acme.sh/acme.sh.env ] && . ~/.acme.sh/acme.sh.env

# zed
alias z='zed'
if [ "$TERM_PROGRAM" = 'zed' ]; then
  export EDITOR="gvim -f"
fi

# Profile end
# set +x
# exec 2>&3 3>&-
