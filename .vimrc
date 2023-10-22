set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set number " line number
set hidden " Allow buffer to be hidden without save change
set encoding=utf-8

set laststatus=2 " Always show status line

nnoremap <Leader>b <Esc>:buffers<CR>:buffer<Space>

let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

syntax on
set nocompatible
filetype indent plugin on

set listchars=tab:>-,space:·,extends:>,precedes:<
set list

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
Plug 'tmsvg/pear-tree'            " auto-pair
Plug 'kylelaker/riscv.vim'        " RISC-V highlight
call plug#end()

" Plug: coc.nvim
let g:coc_global_extensions = ['coc-tsserver']

"inoremap <silent><expr> <TAB>
      "\ coc#pum#visible() ? "\<C-n>" :
      "\ <SID>check_back_space() ? "\<TAB>" :
      "\ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Make <TAB> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#confirm() : "<TAB>"
" Use <c-@> to trigger completion
inoremap <silent><expr> <c-@> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Plug: nerdtree
inoremap <c-b> <Esc>:NERDTreeFocus<cr>
nnoremap <c-b> <Esc>:NERDTreeFocus<cr>

" Plug: easymotion
map <Leader> <Plug>(easymotion-prefix)

" Plug: smooth scroll
nnoremap <silent> <c-u> :call smooth_scroll#up(&scroll, 10, 1)<CR>
nnoremap <silent> <c-d> :call smooth_scroll#down(&scroll, 10, 1)<CR>

" Plug: pear-tree
let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_backspace = 1

" set code scheme
set background=light
if $TERM =~# 'xterm-color\|.*-256color'
  colorscheme PaperColor
endif

" gvim
if has('gui_running')
  set lines=40 columns=150
  set guifont=iAWriterMonoS-Regular:h14
endif
