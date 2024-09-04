" map candidate: H L M
function SwitchListchars()
  if &list
    set nolist
  else
    set list
  endif
endfunction
vnoremap <leader>l :<C-u>call SwitchListchars()<CR>gv

" some useful map
nnoremap Y y$
nnoremap j gj
nnoremap k gk

" Use arrow keys to scroll in popup window
function! ScrollPopup(down)
    let winids = popup_list()
    if empty(winids)
        return 0
    else
        let winid = winids[0]
    endif

    " if the popup window is hidden, then bypass the keystrokes
    let pp = popup_getpos(winid)
    if pp.visible != 1 | return 0 | endif

    let firstline = pp.firstline + a:down
    let buf_lastline = str2nr(trim(win_execute(winid, "echo line('$')")))
    if firstline < 1
        let firstline = 1
    elseif pp.lastline + a:down > buf_lastline
        let firstline = firstline - a:down + buf_lastline - pp.lastline
    endif

    " if a scrollbar is shown, then the height changes
    call popup_setoptions( winid, {'scrollbar': 0, 'resize': 0, 'fixed': 1, 'firstline' : firstline } )

    return 1
endfunction

" auto pair
" inoremap {<CR> {<CR>}<ESC>O
" inoremap [<CR> [<CR>]<ESC>O

function! EditFtplugin(after)
    let l:filetype = &filetype

    if l:filetype == ''
        return
    endif

    if a:after == v:true
        let l:ftplugin_path = '~/.vim/after/ftplugin/' . l:filetype . '.vim'
    else
        let l:ftplugin_path = '~/.vim/ftplugin/' . l:filetype . '.vim'
    endif

    execute 'edit ' . l:ftplugin_path
endfunction

command C call EditFtplugin(v:false)
command Ca call EditFtplugin(v:true)

" Emacs-keys
" start of line
:cnoremap <C-A> <Home>
" back one character
:cnoremap <C-B> <Left>
" delete character under cursor
:cnoremap <C-D> <Del>
" end of line
:cnoremap <C-E> <End>
" forward one character
:cnoremap <C-F> <Right>
" recall newer command-line
:cnoremap <C-N> <Down>
" recall previous (older) command-line
:cnoremap <C-P> <Up>
" back one word
:cnoremap <Esc>b <S-Left>
" forward one word
:cnoremap <Esc>f <S-Right>
