" Plug airline
let g:airline_theme = 'onehalflight'
let g:airline_symbols_ascii = 1
" let g:airline#extensions#tabline#enabled = 1
" let g:airline"extensions#tabline#buffer_idx_mode = 1

" Plug sneak
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
let g:closetag_filetypes = "html,phtml,php"
let g:closetag_filenames = "*.html,*.phtml,*.php"
let g:closetag_xhtml_filetypes = "xhtml,jsx,tsx"
let g:closetag_xhtml_filenames = "*.xhtml,*.jsx,*.tsx"
let g:closetag_emptyTags_caseSensitive = 1

" Plug Leaderf
let g:Lf_WindowPosition = 'popup'
let g:Lf_CommandMap = {'<C-J>': ['<C-N>'], '<C-K>': ['<C-P>']}
let g:Lf_PopupBorders = ["─", "│", "─", "│", "┌", "┐", "┘", "└"]
let g:Lf_StlColorScheme = 'one'
highlight Lf_hl_popupBorder guifg=#555555

" neoformat
let g:neoformat_basic_format_align = 1
let g:neoformat_basic_format_retab = 1
let g:neoformat_basic_format_trim = 1

