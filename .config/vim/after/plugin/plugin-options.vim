" Plug airline && Plug airline-theme
let g:airline_theme = 'onehalflight'
" let g:airline"extensions#tabline#enabled = 1
" let g:airline"extensions#tabline#buffer_idx_mode = 1

" Plug sneak
" let g:sneak#label = 1
noremap f <Plug>Sneak_f
noremap F <Plug>Sneak_F
noremap t <Plug>Sneak_t
noremap T <Plug>Sneak_T
noremap s <Plug>SneakLabel_s
noremap S <Plug>SneakLabel_S
highlight! link Sneak Search

" Plug incsearch
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" Plug vim-closetag
let g:closetag_filenames = "*.html,*.phtml,*.php"
let g:closetag_xhtml_filenames = "*.xhtml,*.jsx,*.tsx"
let g:closetag_filetypes = "html,phtml,php"
let g:closetag_xhtml_filetypes = "xhtml,jsx,tsx"

" Plug Leaderf
let g:Lf_WindowPosition = 'popup'
let g:Lf_CommandMap = {'<C-J>': ['<C-N>'], '<C-K>': ['<C-P>']}
let g:Lf_PopupBorders = ["─", "│", "─", "│", "┌", "┐", "┘", "└"]
let g:Lf_StlColorScheme = 'one'
highlight Lf_hl_popupBorder guifg=#555555

" vifm
" nnoremap <leader>1 :Vifm<CR>
" augroup MyVifm
"     autocmd!
"     autocmd VimLeave * :exe '!rm -f ~/.config/vifm/sessions/' .. g:session_id .. '.json'
"     autocmd BufEnter * g:vifm_exec_args = '-c ''session ' .. g:session_id ..  ''''
"     autocmd BufEnter .bashrc g:vifm_exec_args = '~/.config/bash -c ''session ' .. g:session_id ..  ''''
" augroup END

" neoformat
let g:neoformat_basic_format_align = 1
let g:neoformat_basic_format_retab = 1
let g:neoformat_basic_format_trim = 1

" vimcomplete
" autocmd VimEnter * g:VimCompleteOptionsSet({'completor': {'alwaysOn': false}})

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

