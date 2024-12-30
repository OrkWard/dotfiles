if exists('g:loaded_lsp')
  nnoremap <leader>s :LspFormat<CR>

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
  nnoremap <silent> g[ :<C-U>LspDiag prev<CR>
  nnoremap <silent> g] :<C-U>LspDiag next<CR>
  set keywordprg=:LspHover

  nnoremap <silent> <leader>r :<C-U>LspRename<CR>
  nnoremap <silent> <leader>a :<C-U>LspCodeAction<CR>
endif

" Don't add comment with or
set formatoptions-=or
" Don't limit line width
set tw=0

