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

# lsp
def InitLsp()
  call g:LspAddServer([
    {
      name: 'rust-analyzer',
      path: 'rust-analyzer',
      filetype: ['rust'],
    },
    {
      name: 'rescript',
      path: 'rescript-language-server',
      args: [ '--stdio'],
      filetype: ['rescript'],
      rootSearch: ['rescript.json'],
      initializationOptions: {
        extensionConfiguration: {
          askToStartBuild: false
        }
      }
    }
  ])
  g:LspOptionsSet({'showSignature': false})

  nnoremap <silent> gd :<C-U>LspPeekDefinition<CR>
  nnoremap <silent> gi :<C-U>LspPeekImpl<CR>
  nnoremap <silent> gy :<C-U>LspPeekTypeDef<CR>
  nnoremap <silent> gr :<C-U>LspPeekReferences<CR>
  nnoremap <silent> [d :<C-U>LspDiag prev<CR>
  nnoremap <silent> ]d :<C-U>LspDiag next<CR>
  nnoremap <silent> cd :<C-U>LspRename<CR>
  nnoremap <silent> <leader>a :<C-U>LspCodeAction<CR>

  set keywordprg=:LspHover
enddef
au User LspSetup call InitLsp()

# complete
def InitComplete()
  call g:VimCompleteOptionsSet({
    completor: {
      'alwaysOn': true
    },
    lsp: { 'enable': true }
  })
  g:vimcomplete_cr_enable = 0
  inoremap <expr> <Tab> pumvisible() ? "<C-y>" : "<Tab>"
  inoremap <expr> <CR> pumvisible() ? "<CR><C-e>" : "<CR>"
enddef
autocmd VimEnter * call InitComplete()
