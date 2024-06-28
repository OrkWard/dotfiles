set background=light
if $TERM =~# 'xterm-color\|.*-256color\|alacritty'
  highlight CocFloatDividingLine ctermfg=4
  highlight CocFloatActive ctermfg=4
  highlight ErrorMsg ctermfg=0
endif
