" map candidate: H L M
function SwitchListchars()
  if &list
    set nolist
  else
    set list
  endif
endfunction
vnoremap <leader>l :<C-u>call SwitchListchars()<CR>gv

" some useful map
nnoremap Y y$
nnoremap j gj
nnoremap k gk

