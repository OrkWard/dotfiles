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

# ---------------------- Applications ----------------------------
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
load_module less
load_module node
load_module git
load_module fzf
# load_module complete-alias
load_module autojump
load_module bash-preexec


# ---------------------------- Misc ------------------------------
# custom path for local bin and local script
export PATH="$HOME/.local/bin:$HOME/.local/scripts:$PATH"

# keybinding
bind -x '"\C-t":vifm'

# openai
alias ??="openai"

# caddy
alias server="caddy file-server . --listen localhost:8080"

# rust
export PATH=$HOME/.cargo/bin:$PATH

# go
export GOPATH=~/.gopath
export PATH=$GOPATH/bin:$PATH

# mise
eval "$(mise activate bash)"

# atuin
eval "$(atuin init bash)"

# cd
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# vim
alias vb="vim ~/.bashrc"
alias vv="cd ~/.config/vim && vim vimrc"
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
alias lt="tree -C -I \"node_modules\""

# bat
alias bat='bat --theme=GitHub'

# vscode
alias c='code'
if [ "$TERM_PROGRAM" = 'vscode' ]; then
	_fzf_setup_completion path c
	export EDITOR="gvim -f"
	. "$(code --locate-shell-integration-path bash)"
fi

# Profile end
# set +x
# exec 2>&3 3>&-
