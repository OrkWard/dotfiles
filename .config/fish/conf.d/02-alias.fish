# handy
alias rm='rm -r'
alias mkdir='mkdir -p'

# cd
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# vim
alias vn="nvim ~/.config/nvim/init.lua"
alias vf="tmuxinator fish"
alias vv="tmuxinator vim-plug"
alias vg="tmuxinator ghostty"
alias vt="vim ~/.config/tmux/tmux.conf"


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

# zed
alias z='zed'

