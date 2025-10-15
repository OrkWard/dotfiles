vim9script

# Plug airline && Plug airline-theme
g:airline_theme = 'onehalflight'
# let g:airline#extensions#tabline#enabled = 1
# let g:airline#extensions#tabline#buffer_idx_mode = 1

# Plug sneak
# let g:sneak#label = 1
noremap f <Plug>Sneak_f
noremap F <Plug>Sneak_F
noremap t <Plug>Sneak_t
noremap T <Plug>Sneak_T
noremap s <Plug>SneakLabel_s
noremap S <Plug>SneakLabel_S

# Plug incsearch
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)

# Plug vim-closetag
g:closetag_filenames = "*.html,*.phtml,*.php"
g:closetag_xhtml_filenames = "*.xhtml,*.jsx,*.tsx"
g:closetag_filetypes = "html,phtml,php"
g:closetag_xhtml_filetypes = "xhtml,jsx,tsx"

# Plug Leaderf
g:Lf_WindowPosition = 'popup'
g:Lf_CommandMap = {'<C-J>': ['<C-N>'], '<C-K>': ['<C-P>']}
g:Lf_StlColorScheme = 'one'

# vifm
# nnoremap <leader>1 :Vifm<CR>
# augroup MyVifm
#     autocmd!
#     autocmd VimLeave * :exe '!rm -f ~/.config/vifm/sessions/' .. g:session_id .. '.json'
#     autocmd BufEnter * g:vifm_exec_args = '-c ''session ' .. g:session_id ..  ''''
#     autocmd BufEnter .bashrc g:vifm_exec_args = '~/.config/bash -c ''session ' .. g:session_id ..  ''''
# augroup END

# neoformatter
g:neoformat_basic_format_align = 1
g:neoformat_basic_format_retab = 1
g:neoformat_basic_format_trim = 1

# Plug easymotion
# map f <Plug>(easymotion-f)
# map F <Plug>(easymotion-F)
# nmap , <Plug>(easymotion-next)
# nmap ; <Plug>(easymotion-prev)
# g:EasyMotion_keys = 'asdfghjkl;'

# vimcomplete
# autocmd VimEnter * g:VimCompleteOptionsSet({'completor': {'alwaysOn': false}})

# lsp
# if exists('g:loaded_lsp')
#   nnoremap <leader>s :LspFormat<CR>
#
#   if executable('rust-analyzer')
#     call LspAddServer([#{
#           \ filetype: ['rust'],
#           \ path: 'rust-analyzer',
#           \ args: [],
#           \ syncInit: v:true
#           \ }])
#   endif
#
#   if executable('gopls')
#     call LspAddServer([#{
#          \ filetype: ['go', 'gomod'],
#          \ path: 'gopls',
#          \ args: ['serve'],
#          \ syncInit: v:true
#          \ }])
#   endif
#
#   if executable('pylsp')
#     call LspAddServer([#{
#         \ filetype: 'python',
#         \ path: 'pylsp',
#         \ }])
#   endif
#
#   call LspOptionsSet({'showSignature': v:false})
#
#   nnoremap <silent> gd :<C-U>LspPeekDefinition<CR>
#   nnoremap <silent> gi :<C-U>LspPeekImpl<CR>
#   nnoremap <silent> gy :<C-U>LspPeekTypeDef<CR>
#   nnoremap <silent> gr :<C-U>LspPeekReferences<CR>
#   nnoremap <silent> [d :<C-U>LspDiag prev<CR>
#   nnoremap <silent> ]d :<C-U>LspDiag next<CR>
#   set keywordprg=:LspHover
#
#   nnoremap <silent> <leader>r :<C-U>LspRename<CR>
#   nnoremap <silent> <leader>a :<C-U>LspCodeAction<CR>
# endif

