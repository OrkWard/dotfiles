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
# language
export LC_ALL=en_US.UTF-8
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

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# --------------------- color & prompt ---------------------
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  PS1='($?) '
  PS1+='\[\033[01;32m\]\u '
  PS1+='\[\033[01;34m\]\w '
  PS1+='\[\033[01;33m\]$(__git_ps1 "(%s) ")'
  PS1+='\[\033[00m\]\$ '
else
  PS1='($?) \u@ \w\$ '
fi

# ------------------------- environments -------------------------
export EDITOR=vim
# add local bin, local scripts to PATH
export PATH=~/.local/scripts:~/.local/bin:$PATH

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# go
export GOPATH=~/.gopath
export PATH=$GOPATH/bin:$PATH

# deno
export DENO_INSTALL="/home/orks/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

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

	. $config_dir/git-prompt.sh
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

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# fnm
eval "$(fnm env)"
eval "$(fnm completions)"

# less
export LESS_TERMCAP_mb=$'\e[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\e[1;33m'     # begin blink
export LESS_TERMCAP_so=$'\e[01;44;37m' # begin reverse video
export LESS_TERMCAP_us=$'\e[01;31m'    # begin underline
export LESS_TERMCAP_me=$'\e[0m'        # reset bold/blink
export LESS_TERMCAP_se=$'\e[0m'        # reset reverse video
export LESS_TERMCAP_ue=$'\e[0m'        # reset underline

# fzf
export FZF_DEFAULT_COMMAND="fd -tf -H"
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
	*) fzf --preview 'bat -n --color=always --theme=GitHub {}' "$@" ;;
	esac
}

export FZF_PREVIEW_COMMAND="bat -n --color=always --theme=GitHub {}"

_fzf_setup_completion dir tree
_fzf_setup_completion path rm yadm y bat code

# autojump
. /usr/share/autojump/autojump.bash

# atuin
source $config_dir/bash-preexec.sh
eval "$(atuin init bash)"

# --------------------- alias --------------------
# basic
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias vb="vim ~/.bashrc"
alias vv="vim ~/.vim/vimrc"
alias va="vim ~/.config/alacritty/alacritty.toml"
alias vn="nvim ~/.config/nvim/init.lua"
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
alias gac='git add && git commit -m "$(date)"'
alias gs='git status'
alias gd='git diff'
alias gl='git pull'
alias gp='git push'
alias gt='git-igitt'

# yadm alias
alias y='yadm'
alias yac='yadm add -u && yadm commit -m "$(date)"'
alias ys='yadm status'
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

# alias completion
. $config_dir/complete_alias.sh
complete -F _complete_alias g
complete -F _complete_alias y

#------------------------ Clean ----------------------------
unset machine
unset config_dir
