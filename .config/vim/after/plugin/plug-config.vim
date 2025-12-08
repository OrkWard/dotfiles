" vifm
" nnoremap <leader>1 :Vifm<CR>
" augroup MyVifm
"     autocmd!
"     autocmd VimLeave * :exe '!rm -f ~/.config/vifm/sessions/' .. g:session_id .. '.json'
"     autocmd BufEnter * g:vifm_exec_args = '-c ''session ' .. g:session_id ..  ''''
"     autocmd BufEnter .bashrc g:vifm_exec_args = '~/.config/bash -c ''session ' .. g:session_id ..  ''''
" augroup END

