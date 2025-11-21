" vifm
" nnoremap <leader>1 :Vifm<CR>
" augroup MyVifm
"     autocmd!
"     autocmd VimLeave * :exe '!rm -f ~/.config/vifm/sessions/' .. g:session_id .. '.json'
"     autocmd BufEnter * g:vifm_exec_args = '-c ''session ' .. g:session_id ..  ''''
"     autocmd BufEnter .bashrc g:vifm_exec_args = '~/.config/bash -c ''session ' .. g:session_id ..  ''''
" augroup END

" lsp
if exists('g:loaded_lsp')
  if executable('rust-analyzer')
    call LspAddServer([#{
          \ filetype: ['rust'],
          \ path: 'rust-analyzer',
          \ args: [],
          \ syncInit: v:true
          \ }])
  endif

  if executable('gopls')
    call LspAddServer([#{
          \ filetype: ['go', 'gomod'],
          \ path: 'gopls',
          \ args: ['serve'],
          \ syncInit: v:true
          \ }])
  endif

  if executable('pylsp')
    call LspAddServer([#{
        \ filetype: 'python',
        \ path: 'pylsp',
        \ }])
  endif

  call LspOptionsSet({'showSignature': v:false})

  nnoremap <silent> gd :<C-U>LspPeekDefinition<CR>
  nnoremap <silent> gi :<C-U>LspPeekImpl<CR>
  nnoremap <silent> gy :<C-U>LspPeekTypeDef<CR>
  nnoremap <silent> gr :<C-U>LspPeekReferences<CR>
  nnoremap <silent> [d :<C-U>LspDiag prev<CR>
  nnoremap <silent> ]d :<C-U>LspDiag next<CR>
  set keywordprg=:LspHover

  nnoremap <silent> cd :<C-U>LspRename<CR>
  nnoremap <silent> <leader>a :<C-U>LspCodeAction<CR>
endif

