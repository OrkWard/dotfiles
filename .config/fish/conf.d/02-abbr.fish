# handy
abbr rm "rm -r"
abbr rmf "rm -rf"
abbr mkdir "mkdir -p"

# cd
abbr .. "cd .."
abbr ... "cd ../.."
abbr .... "cd ../../.."

# helix
abbr hf "tmuxinator fish"
abbr hg "tmuxinator ghostty"
abbr ht "hx ~/.config/tmux/tmux.conf"

# yadm
abbr yac "yadm add -u; and yadm commit -m (date)"
abbr ys "yadm status"
abbr yd "yadm diff"
abbr yl "yadm pull"
abbr yp "yadm push"

# ls
abbr ll "ls -alh"
abbr la "ls -a"

abbr serve "caddy file-server . --listen localhost:8080"
abbr tree "lsd --tree --depth 2"

# zed
abbr z 'zed -w'

# git
abbr ga "git add -A"
abbr gc 'git commit'
abbr gcm --set-cursor 'git commit -m "%"'
abbr gac "git add .; git commit -m (date)"
abbr gs "git status"
abbr gsw "git sw"
abbr gsm "git sw master"
abbr gd "git diff"
abbr gds "git diff --staged"
abbr gl "git pull"
abbr gp "git push"
abbr gca "git commit --amend"
abbr gpf "git push --force-with-lease"

# pipe
abbr p0 --position anywhere --set-cursor "%&> /dev/null"
abbr pl --position anywhere --set-cursor "%| less"

# zlua
abbr jb "j -b"
