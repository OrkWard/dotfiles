function! ColorschemeExists(name)
  return !empty(globpath(&rtp, 'colors/' . a:name . '.vim'))
endfunction

if ColorschemeExists('PaperColor')
  colorscheme PaperColor
endif
