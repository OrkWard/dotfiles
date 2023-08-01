set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set nu
set ai
set si
set cindent
set number
set hidden " Allow buffer to be hidden without save change
set encoding=utf-8

syntax on
filetype indent plugin on

" vim-plug
call plug#begin()
Plug 'tpope/vim-surround'
Plug 'preservim/nerdtree'
Plug 'tomasiser/vim-code-dark'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'jiangmiao/auto-pairs'
Plug 'easymotion/vim-easymotion'
Plug 'NLKNguyen/papercolor-theme'
Plug 'terryma/vim-smooth-scroll'
call plug#end()

" Plug: coc.nvim

"inoremap <silent><expr> <TAB>
      "\ coc#pum#visible() ? "\<C-n>" :
      "\ <SID>check_back_space() ? "\<TAB>" :
      "\ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Make <TAB> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Use <c-@> to trigger completion
inoremap <silent><expr> <c-@> coc#refresh()

" Plug: nerdtree
inoremap <c-b> <Esc>:NERDTreeToggle<cr>
nnoremap <c-b> <Esc>:NERDTreeToggle<cr>

" Plug: easymotion
map <Leader> <Plug>(easymotion-prefix)

" Plug: smooth scroll
nnoremap <silent> <c-u> :call smooth_scroll#up(&scroll, 20, 1)<CR>
nnoremap <silent> <c-d> :call smooth_scroll#down(&scroll, 20, 1)<CR>

" set code scheme
set background=light
colorscheme PaperColor

