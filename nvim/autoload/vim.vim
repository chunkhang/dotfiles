" Open repository for Vim plug
function! vim#gx() abort
  let l:line = getline('.')
  let l:repo = matchstr(l:line, "^Plug '\\zs.\\{-}\\ze'")
  if empty(l:repo)
    call netrw#BrowseX(expand('<cfile>'), 0)
    return
  endif
  let l:url = 'https://github.com/' . l:repo
  call netrw#BrowseX(l:url, 0)
endfunction
