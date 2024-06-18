setlocal noexpandtab
setlocal cindent
setlocal tabstop=4
setlocal shiftwidth=4
setlocal keywordprg=man\ 3

let b:SuperTabDisabled = 1

" Vim has no strcmp(), so we implement our own
" https://vi.stackexchange.com/questions/11236/how-do-i-alphabetically-compare-two-strings
function! s:CompareStrings(s1, s2) abort
  if a:s1 < a:s2
    return -1
  elseif a:s1 == a:s2
    return 0
  else
    return 1
  endif
endfunction

function! s:ComparePrototypes(p1, p2) abort
  let l:pat = '[a-zA-Z0-9_]*('
  let l:s1 = matchstr(a:p1, l:pat)
  let l:s2 = matchstr(a:p2, l:pat)
  return s:CompareStrings(l:s1, l:s2)
endfunction

function! s:SortPrototypes(start, end) abort
  let l:lines = getline(a:start, a:end)
  call sort(l:lines, function('s:ComparePrototypes'))
  call setline(a:start, l:lines)
endfunction

" Command that sorts C prototypes based on the function name

" Inspiration:
" https://stackoverflow.com/questions/24401966/unixy-way-of-sorting-c-prototypes-alphabetically
"
" Input:
" void  ft_bzero(void *s, size_t n);
" void  *ft_calloc(size_t count, size_t size);
" int   ft_atoi(const char *src);
"
" Output:
" int   ft_atoi(const char *src);
" void  ft_bzero(void *s, size_t n);
" void  *ft_calloc(size_t count, size_t size);
command -range SortPrototypes call s:SortPrototypes(<line1>, <line2>)

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
else
  let b:undo_ftplugin = ''
endif
let b:undo_ftplugin .=
      \ 'setlocal expandtab< cindent< tabstop< shiftwidth< keywordprg<' .
      \ ' | unlet! b:SuperTabDisabled' .
      \ ' | delcommand SortPrototypes'
