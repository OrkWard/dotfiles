# ================== env =========================
set -gx EDITOR nvim
set -gx LC_ALL en_US.UTF-8
set -gx LC_CTYPE en_US.UTF-8 # for mosh on MacOS
set -gx LANG en_US.UTF-8

set -gx GOPATH $HOME/.go
set -gx GCC_COLORS 'error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
set -gx LS_COLORS 'di=1;38;5;25:ln=38;5;30:ex=1;38;5;28:or=1;38;5;124:mi=1;38;5;124:pi=38;5;130:so=38;5;90:bd=38;5;94:cd=38;5;94:*.go=38;5;24:*.md=38;5;58:*.json=38;5;94:*.yaml=38;5;94:*.yml=38;5;94:*.toml=38;5;94:*.zip=38;5;124:*.gz=38;5;124:*.tar=38;5;124:*.jpg=38;5;90:*.png=38;5;90:*.gif=38;5;90:*.log=38;5;240'
set -gx BAT_THEME GitHub
set -gx FZF_DEFAULT_OPTS "--color light --color 'fg+:red,bg+:-1' --pointer '' \
  --bind 'ctrl-d:preview-page-down' \
  --bind 'ctrl-u:preview-page-up' \
  --bind 'ctrl-/:toggle-preview'"

if [ "$TERM_PROGRAM" = zed ]
    set -gx VISUAL "zed -w"
end

# ================ path ====================
# homebrew
if test $(uname -s) = Darwin
    eval $(/opt/homebrew/bin/brew shellenv)
    set -gx HOMEBREW_NO_ENV_HINTS 1
end

# local bin
fish_add_path --path --move $HOME/.local/bin
# local script
fish_add_path --path --move $HOME/.local/scripts

if status is-interactive
    # ================ prompt ===================
    set fish_greeting
    printf '\e[?12l'

    function fish_prompt
        set -l last_status $status

        set_color green
        echo -n "$USER@$(prompt_hostname) "

        set_color blue
        echo -n (prompt_pwd)' '

        set_color magenta
        echo -n (fish_git_prompt '(%s) ')

        set_color yellow
        echo -n "[$last_status] "(date +"%H:%M:%S")

        set_color normal
        echo
        echo -n '$ '
    end

    # ================ abbr ===================
    # handy
    abbr rmf "rm -rf"
    abbr mkdir "mkdir -p"

    # cd
    abbr .. "cd .."
    abbr ... "cd ../.."
    abbr .... "cd ../../.."

    # vim
    abbr v nvim
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

    # ================ fzf ===================
    function _fzf_pick_file
        set -l result (fzf --query=(commandline -t)); and commandline -rt -- "$result"
        commandline -f repaint
    end

    bind \ct _fzf_pick_file

    # ================ tool init ===================
    # atuin
    if not type -q atuin
        echo "atuin not found"
    else
        atuin init fish | sed 's/-k up/up/' | source
    end

    # zoxide
    zoxide init --cmd j fish | source
end
