###-begin-nr-completion-###

if type complete &>/dev/null; then
  _nr_completion() {
    if ni -v 2>&1 | grep -q "no lock file"; then
      COMPREPLY=()
      return 0
    fi

    local words
    local cur
    local cword
    _get_comp_words_by_ref -n =: cur words cword
    IFS=$'\n'
    COMPREPLY=($(COMP_CWORD=$cword COMP_LINE=$cur nr --completion ${words[@]}))
  }
  complete -F _nr_completion nr
fi

###-end-nr-completion-###
