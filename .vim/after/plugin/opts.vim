if exists('g:loaded_gitblame')
  nnoremap <leader>b :<C-u>call gitblame#echo()<CR>
endif

if exists('g:loaded_airline') && exists('g:loaded_airline_themes')
  let g:airline_theme='papercolor'
  " let g:airline#extensions#tabline#enabled = 1
  " let g:airline#extensions#tabline#buffer_idx_mode = 1
endif

if exists('g:loaded_sneak_plugin')
  let g:sneak#label = 1
  noremap f <Plug>Sneak_f
  noremap F <Plug>Sneak_F
  noremap t <Plug>Sneak_t
  noremap T <Plug>Sneak_T
endif

if exists('g:loaded_fzf') && exists('g:loaded_fzf_vim')
  nnoremap <leader>f :Rg<CR>
  nnoremap g* :Rg<space><c-r><c-w><cr>
  nnoremap <leader>t :Files<CR>
  nnoremap <c-b> :Buffers<CR>
endif

if exists('g:loaded_vifm')
  nnoremap <c-f> :Vifm<CR>
endif

if exists('g:loaded_lexima')
  " let g:lexima_enable_newline_rules = 1
endif

if exists('g:loaded_lsp')
  nnoremap <leader>s :LspFormat<CR>

  call LspAddServer([#{
        \ filetype: ['javascript', 'typescript', 'javascriptreact', 'typescriptreact'],
        \ path: 'typescript-language-server',
        \ args: ['--stdio'],
        \ }])

  call LspAddServer([#{
        \ filetype: ['rust'],
        \ path: 'rust-analyzer',
        \ args: [],
        \ syncInit: v:true
        \ }])

  call LspAddServer([#{
       \ filetype: ['go', 'gomod'],
       \ path: 'gopls',
       \ args: ['serve'],
       \ syncInit: v:true
       \ }])

  call LspAddServer([#{
      \ filetype: 'python',
      \ path: 'pylsp',
      \ }])

  call LspAddServer([#{
      \ filetype: 'json',
      \ path: 'vscode-json-language-server',
      \ args: ['--stdio']
      \ }])

  call LspOptionsSet({'showSignature': v:false})

  nnoremap <silent> gd :<C-U>LspPeekDefinition<CR>
  nnoremap <silent> gi :<C-U>LspPeekImpl<CR>
  nnoremap <silent> gy :<C-U>LspPeekTypeDef<CR>
  nnoremap <silent> gr :<C-U>LspPeekReferences<CR>
  nnoremap <silent> [g :<C-U>LspDiag prev<CR>
  nnoremap <silent> ]g :<C-U>LspDiag next<CR>
  set keywordprg=:LspHover

  nnoremap <silent> <leader>rn :<C-U>LspRename<CR>
endif
