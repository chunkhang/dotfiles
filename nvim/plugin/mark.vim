" Name: mark.vim
" Description: Improvements for working with marks

if exists('g:loaded_mark')
  finish
endif
let g:loaded_mark = 1

" Delete all empty buffers
" https://redd.it/1a4yf1
function! s:ClearEmptyBuffers() abort
  let l:buffers = filter(
        \ range(1, bufnr('$')),
        \ 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val) < 0 &&
        \ (getbufline(v:val, 1, "$") == [""])'
        \ )
  if !empty(l:buffers)
    execute 'bd '.join(l:buffers, ' ')
  endif
endfunction

" Delete all lowercase and uppercase marks
function! s:ClearMarks() abort
  delmarks!
  delmarks A-Z
  wviminfo!
endfunction

augroup plugin_mark
  autocmd!
  " Clear empty buffers when jumping to global marks
  autocmd BufWinEnter * call <SID>ClearEmptyBuffers()
augroup END

noremap <silent> <Plug>MarkClear :call <SID>ClearMarks()<CR>
