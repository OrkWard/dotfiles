function! PackageJsonExists()
  let l:current_dir = expand('%:p:h')

  while l:current_dir !=# '/'
    if filereadable(l:current_dir . '/package.json')
      return true
    endif
    l:current_dir = fnamemodify(l:current_dir, ':h')
  endwhile
  return false
endfunction

if exists(g:loaded_lsp)
  map gq :LspFormat<CR>

  if executable('deno') && !PackageJsonExists()
      call LspAddServer([#{
        \   name: 'deno',
        \   filetype: ['javascript', 'typescript'],
        \   path: 'deno',
        \   args: ['lsp'],
        \   debug: v:true,
        \   initializationOptions: #{
        \        enable: v:true,
        \        lint: v:true
        \   }
        \ }])
  elseif executable('typescript-language-server')
    call LspAddServer([#{
    \ name: 'typescript',
    \ filetype: ['javascript', 'typescript' ],
    \ path: 'typescript-language-server',
    \ args: ['--stdio'],
    \ }])
  endif

endif
