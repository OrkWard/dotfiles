set -x EDITOR vim
set -x LC_ALL en_US.UTF-8
set -x LC_CTYPE en_US.UTF-8 # for mosh on MacOS
set -x LANG en_US.UTF-8

set -x GOPATH $HOME/.go

set fish_greeting

# gcc
set -x GCC_COLORS 'error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

if [ $TERM_PROGRAM = 'zed' ]
  set -x EDITOR "zed -w"
end

