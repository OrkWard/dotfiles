# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# exit on error
#set -e

# detect machine type
case "$(uname -s)" in
Linux*) machine=Linux ;;
Darwin*) machine=Mac ;;
CYGWIN*) machine=Cygwin ;;
MINGW*) machine=MinGw ;;
MSYS_NT*) machine=Git ;;
*) machine="UNKNOWN:${unameOut}" ;;
esac

# set config dir
config_dir=~/.config/bash

# --------------------- Basic ------------------------
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# language
export LC_ALL=en_US.UTF-8

# append to the history file, don't overwrite it
shopt -s histappend

# enable extended globbing
shopt -s extglob

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

# sync history
export PROMPT_COMMAND="history -a; history -n"

# --------------------- color & prompt ---------------------
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
	PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

# ------------------------- environments -------------------------
export EDITOR=vim
export PATH=~/.local/bin:$PATH

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# go
export PATH=$PATH:~/.gopath/bin
export GOPATH=~/.gopath

# remove mail check
unset MAILCHECK

# secrets
if [ -f ~/.secrets.env ]; then
	. ~/.secrets.env

fi

# load machine-specific config
if [ -f ~/.bashrc.local ]; then
	. ~/.bashrc.local
fi

# --------------------- Completion -------------------------
# Linux
if [ $machine = "Linux" ]; then
	alias update='sudo apt update && sudo apt upgrade --autoremove -y'
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

# MaxOS
if [ $machine = "Mac" ]; then
	# completion
	export BASH_COMPLETION_COMPAT_DIR="/usr/local/etc/bash_completion.d"
	complete -cf sudo
	. "/usr/local/etc/profile.d/bash_completion.sh"
fi

# ---------------------- Applications ----------------------------
# homebrew
if [ $machine = "Mac" ]; then
	eval "$(/usr/local/bin/brew shellenv)"
fi

# rust
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# z.sh
. $config_dir/z.sh

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# less
export LESS_TERMCAP_mb=$'\e[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\e[1;33m'     # begin blink
export LESS_TERMCAP_so=$'\e[01;44;37m' # begin reverse video
export LESS_TERMCAP_us=$'\e[01;31m'    # begin underline
export LESS_TERMCAP_me=$'\e[0m'        # reset bold/blink
export LESS_TERMCAP_se=$'\e[0m'        # reset reverse video
export LESS_TERMCAP_ue=$'\e[0m'        # reset underline

# cht.sh
export CHTSH_QUERY_OPTIONS="style=xcode"

# fzf
export FZF_DEFAULT_COMMAND="fd -H"
export FZF_CTRL_T_COMMAND="fd -H"

[ -f $config_dir/fzf-key-bindings.bash ] && . $config_dir/fzf-key-bindings.bash
[ -f $config_dir/fzf-completion.bash ] && . $config_dir/fzf-completion.bash
_fzf_compgen_path() {
	fd -tf -HLE".git" -E".wine" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
	fd -td -HLE".git" . "$1"
}

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
	local command=$1
	shift

	case "$command" in
	cd) fzf --preview 'tree -C {} | head -200' "$@" ;;
	export | unset) fzf --preview "eval 'echo \$'{}" "$@" ;;
	ssh) fzf --preview 'dig {}' "$@" ;;
	*) fzf --preview 'bat -n --color=always {}' "$@" ;;
	esac
}

_fzf_setup_completion dir tree
_fzf_setup_completion path rm yadm y bat code

# alias completion
. $config_dir/complete_alias.sh
complete -F _complete_alias g
complete -F _complete_alias y

# --------------------- alias --------------------
# basic
alias ..="cd .."
alias ...="cd ..."
alias vb="vim ~/.bashrc"
alias vv="vim ~/.vimrc"
alias va="vim ~/.config/alacritty/alacritty.toml"
alias vn="vim ~/.config/nvim/init.lua"
alias vt="vim ~/.tmux.conf"
alias v3="vim ~/.config/i3/config"

# code
if [ "$TERM_PROGRAM" = 'vscode' ]; then
	alias c='code'
	_fzf_setup_completion path c
fi

# git alias
alias g='git'
alias ga='git add .'
alias gc='git cz'
alias gcm='git commit -m'
alias gs='git status'
alias gd='git diff'
alias gl='git pull'
alias gp='git push'

# yadm alias
alias y='yadm'
alias ya='yadm add -u'
alias ys='yadm status'
alias yc='yadm commit -m'
alias yd='yadm diff'
alias yl='yadm pull'
alias yp='yadm push'

# eza
alias e='eza'
alias ea='eza -a'
alias el='eza -l'

# ls aliases
alias ls='ls -F --color=auto'
alias ll='ls -al'
alias la='ls -A'

# other alias
alias d='dust'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# bat
alias bat='bat --theme=GitHub'

# ripgrep
alias rg='rg --no-heading --column'

#------------------------ Clean ----------------------------
unset machine
unset config_dir
