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
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#buffer_idx_mode = 1
  nmap <leader>1 <Plug>AirlineSelectTab1
  nmap <leader>2 <Plug>AirlineSelectTab2
  nmap <leader>3 <Plug>AirlineSelectTab3
  nmap <leader>4 <Plug>AirlineSelectTab4
  nmap <leader>5 <Plug>AirlineSelectTab5
  nmap <leader>6 <Plug>AirlineSelectTab6
  nmap <leader>7 <Plug>AirlineSelectTab7
  nmap <leader>8 <Plug>AirlineSelectTab8
  nmap <leader>9 <Plug>AirlineSelectTab9
  nmap <leader>0 <Plug>AirlineSelectTab0
  nmap <leader>- <Plug>AirlineSelectPrevTab
  nmap <leader>+ <Plug>AirlineSelectNextTab
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
endif

if exists('g:loaded_vifm')
  nnoremap <c-f> :Vifm<CR>
endif

if exists('g:loaded_lexima')
  let g:lexima_enable_newline_rules = 0
endif

if exists('g:loaded_lsp')
  call LspAddServer([#{
        \ name: 'typescriptlang',
        \ filetype: ['javascript', 'typescript', 'javascriptreact', 'typescriptreact'],
        \ path: 'typescript-language-server',
        \ args: ['--stdio'],
        \ }])

  call LspAddServer([#{
        \ name: 'rustlang',
        \ filetype: ['rust'],
        \ path: 'rust-analyzer',
        \ args: [],
        \ syncInit: v:true
        \ }])

  call LspOptionsSet({'showSignature': v:false})

  nnoremap <silent> gd :<C-U>LspGotoDefinition<CR>
  nnoremap <silent> gi :<C-U>LspGotoImpl<CR>
  nnoremap <silent> gy :<C-U>LspGotoTypeDef<CR>
  nnoremap <silent> [g :<C-U>LspDiag prev<CR>
  nnoremap <silent> ]g :<C-U>LspDiag next<CR>
  set keywordprg=:LspHover

  nnoremap <silent> <leader>rn :<C-U>LspRename<CR>
endif
