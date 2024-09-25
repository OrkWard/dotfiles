set background=light

function! ColorschemeExists(name)
  return !empty(globpath(&rtp, 'colors/' . a:name . '.vim'))
endfunction

if ColorschemeExists('PaperColor')
  colorscheme PaperColor
endif

" Only custom after colorscheme change
if $TERM =~# 'xterm-color\|.*-256color\|alacritty'
  highlight CocFloatDividingLine ctermfg=4
  highlight CocFloatActive ctermfg=4
  highlight ErrorMsg ctermfg=0
endif
