# handy
abbr rm "rm -r"
abbr rmf "rm -rf"
abbr mkdir "mkdir -p"

# cd
abbr .. "cd .."
abbr ... "cd ../.."
abbr .... "cd ../../.."

# vim
abbr v "nvim"
abbr vf "j fish"
abbr vg "j ghostty"
abbr vt "nvim ~/.config/tmux/tmux.conf"

# yadm
abbr yac --set-cursor 'yadm add -u; yadm commit -m "%"'
abbr ys "yadm status"
abbr yd "yadm diff"
abbr yds "yadm diff --staged"
abbr yl "yadm pull"
abbr yp "yadm push"

# ls
abbr l ls
abbr ll "ls -alhF"
abbr la "ls -a"

abbr serve "caddy file-server . --listen localhost:8080"
abbr tree "tree -L2 -C"

# zed
abbr z 'zed -w'

# git
abbr ga "git add -A"
abbr gau "git add -u"
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
abbr gxp "git xpush"

# pipe
abbr p0 --position anywhere --set-cursor "%&> /dev/null"
abbr pl --position anywhere --set-cursor "%| less"

# docker
abbr dc "docker compose"

