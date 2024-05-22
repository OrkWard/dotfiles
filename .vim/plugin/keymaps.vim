" map candidate: H L M
function SwitchListchars()
  if &listchars == ''
    let &listchars = 'tab:| ,space:·,extends:>,precedes:<,leadmultispace:|·'
  else
    let &listchars = ''
  endif
endfunction
vnoremap <leader>l :<C-u>call SwitchListchars()<CR>gv

" some useful map
nnoremap Y y$
nnoremap j gj
nnoremap k gk

