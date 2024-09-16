" Name: window.vim
" Description: Improvements for working with windows

if exists('g:loaded_window')
  finish
endif
let g:loaded_window = 1

" Split window into given direction
function! s:SplitWindow(direction) abort
  let l:toggled = v:false

  if a:direction ==# 'left'
    if &splitright
      set nosplitright
      let l:toggled = v:true
    endif

    vsplit

    if l:toggled
      set splitright
    endif
  endif

  if a:direction ==# 'right'
    if !&splitright
      set splitright
      let l:toggled = v:true
    endif

    vsplit

    if l:toggled
      set nosplitright
    endif
  endif

  if a:direction ==# 'up'
    if &splitbelow
      set nosplitbelow
      let l:toggled = v:true
    endif

    split

    if l:toggled
      set splitbelow
    endif
  endif

  if a:direction ==# 'down'
    if !&splitbelow
      set splitbelow
      let l:toggled = v:true
    endif

    split

    if l:toggled
      set nosplitbelow
    endif
  endif
endfunction

augroup plugin_window
  autocmd!
  " Make it easy to quit to for certain type of windows
  " Instead of typing :q, just a simple q in normal mode will do
  autocmd FileType help,qf,godoc noremap <silent> <buffer> q :quit<CR>
augroup END

noremap <silent> <Plug>WindowSplitLeft :call <SID>SplitWindow('left')<CR>
noremap <silent> <Plug>WindowSplitRight :call <SID>SplitWindow('right')<CR>
noremap <silent> <Plug>WindowSplitUp :call <SID>SplitWindow('up')<CR>
noremap <silent> <Plug>WindowSplitDown :call <SID>SplitWindow('down')<CR>
