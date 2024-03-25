
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
set splitbelow " default split on the below
set laststatus=2 " Always show status line
set list
set listchars=tab:>-,space:·,extends:>,precedes:<
" set listchars=tab:>-,extends:>,precedes:<

let mapleader = " "

filetype indent plugin on
syntax on

autocmd BufNewFile,BufWinEnter * setlocal formatoptions=trc " Don't auto insert comment leader on return/hitting 'o'

" some useful map
nnoremap Y y$
nnoremap j gj
nnoremap k gk

" nnoremap <space> za
" vnoremap <space> zf

" set cursor
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

" ------------------------------ Plugins ------------------------------

" vim-plug
call plug#begin()
Plug 'wakatime/vim-wakatime'
Plug 'liuchengxu/vim-which-key'
Plug 'justinmk/vim-sneak'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'vim-airline/vim-airline'    " airline
Plug 'vim-airline/vim-airline-themes' " airline theme
Plug 'NLKNguyen/papercolor-theme' " White Theme
Plug 'preservim/nerdtree'
Plug 'pangloss/vim-javascript'    " JavaScript support
Plug 'leafgarland/typescript-vim' " TypeScript syntax
Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax
Plug 'kylelaker/riscv.vim'        " RISC-V highlight
Plug 'tpope/vim-commentary'       " comment
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
call plug#end()

" Plug: coc.nvim
let g:coc_global_extensions = ['coc-tsserver', 'coc-clangd', 'coc-go', 'coc-vimlsp']

inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#confirm() : "<TAB>"
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent> <c-c> <ESC>:call coc#pum#cancel()<CR>

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

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

" Plug: airline
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

" Plug: vim-sneak
let g:sneak#label = 1

" Plug: fzf
" nnoremap <C-f> :FZF<CR>
" nnoremap <C-t> :call fzf#run({'source': 'ls', 'sink': 'e'})<CR>
nnoremap <Leader>b :Buffers<CR>

" Plug: nerdtree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Plug: which-key
set timeoutlen=500
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

" set code scheme
set background=light
if $TERM =~# 'xterm-color\|.*-256color\|alacritty'
  colorscheme PaperColor
  highlight CocFloatDividingLine ctermfg=4
  highlight ErrorMsg ctermfg=0
endif
