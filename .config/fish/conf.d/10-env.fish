set -gx EDITOR vim
set -gx LC_ALL en_US.UTF-8
set -gx LC_CTYPE en_US.UTF-8 # for mosh on MacOS
set -gx LANG en_US.UTF-8

set -gx GOPATH $HOME/.go

set fish_greeting

# gcc
set -gx GCC_COLORS 'error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

if [ $TERM_PROGRAM = 'zed' ]
  set -gx EDITOR "zed -w"
end

