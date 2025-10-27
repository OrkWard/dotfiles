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
