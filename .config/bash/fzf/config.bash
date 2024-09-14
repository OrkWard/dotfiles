export FZF_DEFAULT_COMMAND='fd -tf -H -L -E".git" -E".wine" -E"node_modules"'
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
	export | unset) fzf --preview "eval 'echo \$'{}" "$@" ;;
	ssh) fzf --preview 'dig {}' "$@" ;;
	*) fzf --preview 'bat -n --color=always --theme=GitHub {}' "$@" ;;
	esac
}

_fzf_setup_completion dir tree
_fzf_setup_completion path bat code glow
