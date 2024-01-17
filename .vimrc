" ------------------------------ Basics ------------------------------
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent

set relativenumber " relative line number

set hidden " Allow buffer to be hidden without save change

set encoding=utf-8
set cursorcolumn
set cursorline

set splitbelow " default split in below

set laststatus=2 " Always show status line

set list
set listchars=tab:>-,space:·,extends:>,precedes:<
" set listchars=tab:>-,extends:>,precedes:<

filetype indent plugin on

autocmd BufNewFile,BufWinEnter * setlocal formatoptions=trc " Don't auto insert comment leader on return/hitting 'o'

nnoremap <Leader>b <Esc>:buffers<CR>:buffer<Space>

" some useful map
nnoremap zq ZQ
nnoremap za :qa!<CR>
nnoremap zz ZZ
nnoremap Y y$

nnoremap j gj
nnoremap k gk

nnoremap <silent><ESC>1 1gt
nnoremap <silent><ESC>2 2gt
nnoremap <silent><ESC>3 3gt
nnoremap <silent><ESC>4 4gt
nnoremap <silent><ESC>5 5gt
nnoremap <silent><ESC>6 6gt
nnoremap <silent><ESC>7 7gt
nnoremap <silent><ESC>8 8gt
nnoremap <silent><ESC>9 9gt
nnoremap <silent><ESC>0 0gt

if $TERM_PROGRAM ==# 'iTerm.app'
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_SR = "\<Esc>]50;CursorShape=2\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
else
  let &t_SI = "\<Esc>[6 q"
  let &t_SR = "\<Esc>[4 q"
  let &t_EI = "\<Esc>[2 q"
endif

syntax on

" ------------------------------ Plugins ------------------------------

" vim-plug
call plug#begin()
Plug 'wakatime/vim-wakatime'      " wakatime
Plug 'justinmk/vim-sneak'         " Sneak
Plug 'tpope/vim-surround'         " Vim Surround
Plug 'tomasiser/vim-code-dark'    " VS Code Dark Theme
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'vim-airline/vim-airline'    " airline
Plug 'vim-airline/vim-airline-themes' " airline theme
Plug 'easymotion/vim-easymotion'  " EasyMotion
Plug 'NLKNguyen/papercolor-theme' " White Theme
Plug 'psliwka/vim-smoothie'       " smooth scroll
Plug 'pangloss/vim-javascript'    " JavaScript support
Plug 'leafgarland/typescript-vim' " TypeScript syntax
Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax
Plug 'tmsvg/pear-tree'            " auto-pair
Plug 'kylelaker/riscv.vim'        " RISC-V highlight
Plug 'tpope/vim-commentary'       " comment
Plug 'junegunn/fzf'               " fzf
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
call plug#end()

" Plug: coc.nvim
let g:coc_global_extensions = ['coc-tsserver', 'coc-clangd']

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

" Plug: easymotion
map <Leader> <Plug>(easymotion-prefix)

" Plug airline
let g:airline_theme='papercolor'

" Plug: pear-tree
let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_backspace = 1

" Plug: vim-sneak
nnoremap f <Plug>Sneak_s
nnoremap F <Plug>Sneak_S

" set code scheme
set background=light
if $TERM =~# 'xterm-color\|.*-256color\|alacritty'
  colorscheme PaperColor
endif

" ------------------------------ gvim ------------------------------
if has('gui_running')
  set lines=40 columns=150
  set guifont=iAWriterMonoS-Regular:h14
endif
