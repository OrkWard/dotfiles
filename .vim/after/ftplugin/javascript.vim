if exists(g:loaded_lsp)
  map gq :LspFormat<CR>

  if executable('typescript-language-server')
    call LspAddServer([#{
    \ name: 'typescript',
    \ filetype: ['javascript', 'typescript' ],
    \ path: 'typescript-language-server',
    \ args: ['--stdio'],
    \ }])
  endif

endif
