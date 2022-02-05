" Name: syntax.vim
" Description: Utilities for working with syntax

if exists('g:loaded_syntax')
  finish
endif
let g:loaded_syntax = 1

" Print highlight groups under cursor
" https://stackoverflow.com/a/9464929
function! s:ShowHighlightGroups() abort
  if !exists('*synstack')
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction

noremap <silent> <Plug>SyntaxShowHighlightGroups :call <SID>ShowHighlightGroups()<CR>
