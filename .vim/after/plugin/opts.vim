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

if exists('g:EasyMotion_loaded')
  map f <Plug>(easymotion-bd-f)
  map F <Plug>(easymotion-bd-F)
endif

if exists('g:loaded_incsearch')
  map / <Plug>(incsearch-forward)
  map ? <Plug>(incsearch-backward)
endif

if exists('g:loaded_fzf') && exists('g:loaded_fzf_vim')
  nnoremap <leader>F :Rg<CR>
  nnoremap g* :Rg<space><c-r><c-w><cr>
  nnoremap <c-f> :Files<CR>
  nnoremap <c-p> :Buffers<CR>
endif

if exists('g:loaded_vifm')
  nnoremap <leader>v :Vifm<CR>
endif

if exists('g:loaded_lexima')
  " let g:lexima_enable_newline_rules = 1
endif

if exists('g:loaded_lsp')
  nnoremap <leader>s :LspFormat<CR>

  let lsps = []

  if executable('rust-analyzer')
    call add(lsps, 'rust')
    call LspAddServer([#{
          \ filetype: ['rust'],
          \ path: 'rust-analyzer',
          \ args: [],
          \ syncInit: v:true
          \ }])
  endif

  if executable('gopls')
    call add(lsps, 'go')
    call LspAddServer([#{
         \ filetype: ['go', 'gomod'],
         \ path: 'gopls',
         \ args: ['serve'],
         \ syncInit: v:true
         \ }])
  endif

  if executable('pylsp')
    call add(lsps, 'py')
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

  nnoremap <silent> <leader>rn :<C-U>LspRename<CR>
endif
