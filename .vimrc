set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set nu
set ai
set si
set cindent
set number
set hidden " Allow buffer to be hidden without save change
set encoding=utf-8

set laststatus=2 " Always show  status line

syntax on
filetype off

" vim-plug
call plug#begin()
Plug 'tpope/vim-surround'         " Vim Surround
Plug 'preservim/nerdtree'         " File Explorer
Plug 'tomasiser/vim-code-dark'    " VS Code Dark Theme
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'vim-airline/vim-airline'    " airline
Plug 'easymotion/vim-easymotion'  " EasyMotion
Plug 'NLKNguyen/papercolor-theme' " White Theme
Plug 'terryma/vim-smooth-scroll'  " Smooth scroll
Plug 'pangloss/vim-javascript'    " JavaScript support
Plug 'leafgarland/typescript-vim' " TypeScript syntax
Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax
Plug 'jparise/vim-graphql'        " GraphQL syntax
call plug#end()
filetype indent plugin on

" Plug: coc.nvim
let g:coc_global_extensions = ['coc-tsserver']

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
nnoremap <silent> <c-u> :call smooth_scroll#up(&scroll, 30, 1)<CR>
nnoremap <silent> <c-d> :call smooth_scroll#down(&scroll, 30, 1)<CR>

" set code scheme
set background=light
colorscheme PaperColor

" gvim
if has('gui_running')
  set lines=40 columns=150
  set guifont=iAWriterMonoS-Regular:h14
endif
