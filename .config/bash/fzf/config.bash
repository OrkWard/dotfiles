export FZF_DEFAULT_COMMAND='fd -tf -H -L -E".git" -E".wine" -E"node_modules" -E"*.swp"'
export FZF_PREVIEW_COMMAND="bat -n --color=always --theme=GitHub {}"

# generate file path
_fzf_compgen_path() {
  fd -tf -H -L -E".git" -E".wine" -E"node_modules" . "$1"
}

# generate dir path
_fzf_compgen_dir() {
  fd -td -HLE".git" -E"node_modules" . "$1"
}

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd) fzf --preview 'tree -C {} | head -200' "$@" ;;
    export | unset) fzf --preview "eval 'echo $'{}" "$@" ;;
    ssh) fzf --preview 'dig {}' "$@" ;;
    *) fzf --preview 'bat -n --color=always --theme=GitHub {}' "$@" ;;
  esac
}

__fzfcmd() {
  [[ -n "${TMUX_PANE-}" ]] && { [[ "${FZF_TMUX:-0}" != 0 ]] || [[ -n "${FZF_TMUX_OPTS-}" ]]; } &&
    echo "fzf-tmux ${FZF_TMUX_OPTS:--d${FZF_TMUX_HEIGHT:-40%}} -- " || echo "fzf"
}

__fzf_defaults() {
  # $1: Prepend to FZF_DEFAULT_OPTS_FILE and FZF_DEFAULT_OPTS
  # $2: Append to FZF_DEFAULT_OPTS_FILE and FZF_DEFAULT_OPTS
  echo "--height ${FZF_TMUX_HEIGHT:-40%} --min-height 20+ --bind=ctrl-z:ignore $1"
  command cat "${FZF_DEFAULT_OPTS_FILE-}" 2> /dev/null
  echo "${FZF_DEFAULT_OPTS-} $2"
}
__fzf_cd__() {
  local dir
  dir=$(
    FZF_DEFAULT_COMMAND=${FZF_ALT_C_COMMAND:-}
    FZF_DEFAULT_OPTS=$(__fzf_defaults "--reverse --walker=dir,follow,hidden --scheme=path" "${FZF_ALT_C_OPTS-}  m")
    FZF_DEFAULT_OPTS_FILE='' $(__fzfcmd)
  ) && printf 'builtin cd -- %q' "$(builtin unset CDPATH && builtin cd -- "$dir" && builtin pwd)"
}
bind -m emacs-standard '"\ec": " \C-b\C-k \C-u`__fzf_cd__`\e\C-e\er\C-m\C-y\C-h\e \C-y\ey\C-x\C-x\C-d"'

_fzf_setup_completion dir tree
_fzf_setup_completion path bat code glow
