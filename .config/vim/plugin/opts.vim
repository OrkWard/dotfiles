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

# Plug fzf
nnoremap <leader>f :Rg<CR>
nnoremap g* :Rg<space><c-r><c-w><cr>
nnoremap <c-f> :Files<CR>
nnoremap <c-p> :Buffers<CR>

# vifm
$FZF_DEFAULT_COMMAND = 'fd -tf -td -H -L -E".git" -E".wine" -E"node_modules" -E"*.swp"'
nnoremap <leader>1 :Vifm<CR>
augroup MyVifm
    autocmd!
    autocmd VimLeave * :exe '!rm -f ~/.config/vifm/sessions/' .. g:session_id .. '.json'
    autocmd BufEnter * g:vifm_exec_args = '-c ''session ' .. g:session_id ..  ''''
    autocmd BufEnter .bashrc g:vifm_exec_args = '~/.config/bash -c ''session ' .. g:session_id ..  ''''
augroup END

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
