# fzf.fish
set -gx fzf_fd_opts --hidden --follow --exclude=.git --exclude=.wine --exclude=node_modules --exclude='*.swp'

set -gx fzf_preview_file_cmd bat --color=always --theme=GitHub
set -gx fzf_preview_dir_cmd tree -C
