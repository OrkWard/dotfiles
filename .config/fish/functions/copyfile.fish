function copyfile
  if test -z "$argv[1]"
    return
  end

  set -l input[1] 'begin;'
  set -l input[2] 'read -P "filename> " -l file;'
  set -l input[3] 'echo "'
  set -l input[4] (cat $argv[1] | base64 -w0)
  set -l input[5] '" | base64 -d -o $file;'
  set -l input[6] 'end;'

  printf "\033]52;c;%s\007" (string join " " $input | base64 -w0)
end
