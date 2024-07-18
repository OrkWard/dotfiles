# If not running interactively, don't do anything
case $- in
	*i*) ;;
	*) return ;;
esac

# --------------------- Basic ------------------------
export EDITOR=vim

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
PS1='\[\033]133;A\033\\\]($?) '
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	PS1+='\[\033[01;32m\]\u '
	PS1+='\[\033[01;34m\]\w '
	PS1+='\[\033[01;33m\]$(__git_ps1 "(%s) ")'
	PS1+='\[\033[00m\]\$ '
else
	PS1+='\u@ \w\$ '
fi

# ---------------------- Applications ----------------------------
config_dir=~/.config/bash

loadModule() {
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

loadModule local
loadModule less
loadModule node
loadModule git
loadModule fzf
loadModule complete-alias
loadModule pyenv
loadModule autojump
loadModule bash-preexec

# atuin
eval "$(atuin init bash)"

# cd
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# vim
alias vb="vim ~/.bashrc"
alias vv="vim ~/.vim/vimrc"
alias va="vim ~/.config/alacritty/alacritty.toml"
alias vn="nvim ~/.config/nvim/init.lua"
alias vt="vim ~/.tmux.conf"
alias v3="vim ~/.config/i3/config"

# gcc
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# yadm
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
alias eg='eza -gl'

# ls
alias ls='ls -F --color=auto'
alias ll='ls -al'
alias la='ls -A'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# bat
alias bat='bat --theme=GitHub'

# vscode
if [ "$TERM_PROGRAM" = 'vscode' ]; then
	alias c='code'
	_fzf_setup_completion path c
	. "$(code --locate-shell-integration-path bash)"
fi
