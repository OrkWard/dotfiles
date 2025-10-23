# handy
abbr rm "rm -r"
abbr mkdir "mkdir -p"

# cd
abbr .. "cd .."
abbr ... "cd ../.."
abbr .... "cd ../../.."

# vim
abbr vn "nvim ~/.config/nvim/init.lua"
abbr vf "tmuxinator fish"
abbr vv "tmuxinator vim-plug"
abbr vg "tmuxinator ghostty"
abbr vt "vim ~/.config/tmux/tmux.conf"


# yadm
abbr yac "yadm add -u; and yadm commit -m (date)"
abbr ys "yadm status"
abbr yd "yadm diff"
abbr yl "yadm pull"
abbr yp "yadm push"

# ls
abbr l "ls --color"
abbr ls "ls --color"
abbr ll "ls --color -alh"
abbr la "ls --color -a"

abbr bat "bat --theme=GitHub"
abbr serve "caddy file-server . --listen localhost:8080"
abbr tree "lsd --tree --depth 2"

# zed
abbr z "zed"

# git
abbr ga "git add -A"
abbr gcm --set-cursor 'git commit -m "%"'
abbr gac "git add .; git commit -m (date)"
abbr gs "git status"
abbr gd "git diff"
abbr gds "git diff --staged"
abbr gl "git pull"
abbr gp "git push"
abbr gca "git commit --amend"
abbr gpf "git push --force-with-lease"

# pipe
abbr p0 --position anywhere --set-cursor "% &> /dev/null"
abbr pl --position anywhere --set-cursor "% | less"
