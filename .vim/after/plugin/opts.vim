if exists('g:did_coc_loaded')
  let g:coc_global_extensions = ['coc-tsserver', 'coc-clangd', 'coc-go', 'coc-snippets', 'coc-json', 'coc-rust-analyzer', 'coc-pyright']

  inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#confirm() : "<TAB>"
  inoremap <silent><expr> <c-space> coc#refresh()

  " Use `[g` and `]g` to navigate diagnostics
  " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)

  " GoTo code navigation
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Applying code actions to the selected code block
  " Example: `<leader>aap` for current paragraph
  xmap <leader>a  <Plug>(coc-codeaction-selected)
  nmap <leader>a  <Plug>(coc-codeaction-selected)

  " Remap keys for applying code actions at the cursor position
  nmap <leader>ac  <Plug>(coc-codeaction-cursor)
  " Remap keys for apply code actions affect whole buffer
  nmap <leader>as  <Plug>(coc-codeaction-source)
  " Apply the most preferred quickfix action to fix diagnostic on the current line
  nmap <leader>qf  <Plug>(coc-fix-current)

  " Use K to show documentation in preview window
  nnoremap <silent> K :call ShowDocumentation()<CR>

  function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
      call CocActionAsync('doHover')
    else
      call feedkeys('K', 'in')
    endif
  endfunction

  " Symbol renaming
  nmap <leader>rn <Plug>(coc-rename)

  " Formatting selected code
  xmap <leader>f <Plug>(coc-format-selected)
endif

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
  if executable('typescript-language-server')
    call LspAddServer([#{
          \ name: 'typescriptlang',
          \ filetype: ['javascript', 'typescript', 'javascriptreact', 'typescriptreact'],
          \ path: 'typescript-language-server',
          \ args: ['--stdio'],
          \ }])
  endif

  if executable('rust-analyzer')
    call LspAddServer([#{
          \ name: 'rustlang',
          \ filetype: ['rust'],
          \ path: 'rust-analyzer',
          \ args: [],
          \ syncInit: v:true
          \ }])
  endif

  if executable('gopls')
    call LspAddServer([#{
         \ name: 'golang',
         \ filetype: ['go', 'gomod'],
         \ path: 'gopls',
         \ args: ['serve'],
         \ syncInit: v:true
         \ }])
  endif

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
