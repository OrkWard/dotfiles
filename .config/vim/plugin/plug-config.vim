vim9script
# Plug airline
g:airline_theme = 'onehalflight'
g:airline_symbols_ascii = 1
# let g:airline#extensions#tabline#enabled = 1
# let g:airline#extensions#tabline#buffer_idx_mode = 1

# Plug sneak
noremap f <Plug>Sneak_f
noremap F <Plug>Sneak_F
noremap t <Plug>Sneak_t
noremap T <Plug>Sneak_T
noremap s <Plug>SneakLabel_s
noremap S <Plug>SneakLabel_S
highlight! link Sneak Search

# Plug incsearch
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

# Plug vim-closetag
g:closetag_filetypes = "html,phtml,php"
g:closetag_filenames = "*.html,*.phtml,*.php"
g:closetag_xhtml_filetypes = "xhtml,jsx,tsx"
g:closetag_xhtml_filenames = "*.xhtml,*.jsx,*.tsx"
g:closetag_emptyTags_caseSensitive = 1

# Plug Leaderf
g:Lf_WindowPosition = 'popup'
g:Lf_CommandMap = {'<C-J>': ['<C-N>'], '<C-K>': ['<C-P>']}
g:Lf_PopupBorders = ["─", "│", "─", "│", "┌", "┐", "┘", "└"]
g:Lf_StlColorScheme = 'one'
g:Lf_EnableCircularScroll = 1
g:Lf_RememberLastSearch = 1
highlight Lf_hl_popupBorder guifg=#555555
nnoremap <silent> <leader>F :<C-U>LeaderfRgInteractive<CR>
nnoremap <silent> <leader>R :<C-U>LeaderfRgRecall<CR>

# neoformat
g:neoformat_basic_format_align = 1
g:neoformat_basic_format_retab = 1
g:neoformat_basic_format_trim = 1
