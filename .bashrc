# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

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

# --------------------- color & prompt ---------------------
# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  xterm-color|*-256color|alacritty) color_prompt=yes;;
esac

#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi

if [ "$color_prompt" = yes ]; then
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# --------------------- xterm ----------------------
# If this is an xterm set the title to user@host:dir
case "$TERM" in
  xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
  *)
    ;;
esac

# ------------------------- environments -------------------------
export EDITOR=vim
export PATH=~/.local/bin:$PATH

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# go
export PATH=$PATH:/usr/local/go/bin
export GOPATH=~/.gopath

# secrets
if [ -f ~/.secrets.env ]; then
  . ~/.secrets.env
fi

# -------------------------- completion --------------------------
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# fzf
[ -f /usr/share/doc/fzf/examples/key-bindings.bash ] && source /usr/share/doc/fzf/examples/key-bindings.bash
[ -f /usr/share/bash-completion/completions/fzf ] && source /usr/share/bash-completion/completions/fzf
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'tree -C {} | head -200'   "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview 'bat -n --color=always {}' "$@" ;;
  esac
}

_fzf_setup_completion dir tree
_fzf_setup_completion path rm yadm y bat

# mzz2017/gg complete
complete -F _command gg


# --------------------- alias --------------------
# basic
alias ..="cd .."
alias ...="cd ..."
alias vb="vim ~/.bashrc"
alias vv="vim ~/.vimrc"
alias va="vim ~/.config/alacritty/alacritty.yml"
alias vn="nvim ~/.config/nvim/init.lua"

# bash alias
alias setc='export TERM=xterm-256color && exec bash'

# code
if [ "$TERM_PROGRAM" = 'vscode' ]; then
  alias c='code'
  _fzf_setup_completion path c
fi

# git alias
alias g='git'
alias ga='git add .'
alias gc='git commit -m'
alias gs='git status'
alias gd='git diff'

# yadm alias
alias y='yadm'
alias ya='yadm add -u'
alias ys='yadm status'
alias yc='yadm commit -m'
alias yd='yadm diff'

# eza
alias e='eza'

# ls aliases
alias ls='ls -F --color=auto'
alias ll='ls -al'
alias la='ls -A'

# other alias
alias d='du -hd1'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# kardolus/chatgpt-cli
alias ??="chatgpt"

# bat
alias bat='bat --theme=GitHub'

# ---------------------- applications ----------------------------
# rust
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# z.sh
. ~/.local/source/z.sh

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# less
export LESS_TERMCAP_mb=$'\e[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\e[1;33m'     # begin blink
export LESS_TERMCAP_so=$'\e[01;44;37m' # begin reverse video
export LESS_TERMCAP_us=$'\e[01;31m'    # begin underline
export LESS_TERMCAP_me=$'\e[0m'        # reset bold/blink
export LESS_TERMCAP_se=$'\e[0m'        # reset reverse video
export LESS_TERMCAP_ue=$'\e[0m'        # reset underline

# --------------------- Machine-Specific -------------------------
# detect machine type
case "$(uname -s)" in
  Linux*)     machine=Linux;;
  Darwin*)    machine=Mac;;
  CYGWIN*)    machine=Cygwin;;
  MINGW*)     machine=MinGw;;
  MSYS_NT*)   machine=Git;;
  *)          machine="UNKNOWN:${unameOut}"
esac

# Linux
if [ $machine = "Linux" ]; then
  alias update='sudo apt update && sudo apt upgrade --autoremove -y'
fi

# MaxOS
if [ $machine = "Mac" ]; then
  [[ -f /use/local/bin/brew ]] && eval "$(/usr/local/bin/brew shellenv)"
  # completion
  export BASH_COMPLETION_COMPAT_DIR="/usr/local/etc/bash_completion.d"
  complete -cf sudo
  [[ -r "/usr/local/share/bash-completion/bash_completion" ]] && . "/usr/local/share/bash-completion/bash_completion"
fi

unset machine

if [ -f ~/.bashrc.local ]; then
  . ~/.bashrc.local
fi

