" Open repository for Go import
function! go#gx() abort
  let l:line = getline('.')
  let l:url = matchstr(l:line, '"\zs.*\ze"')
  if empty(l:url)
    return
  endif
  let l:url = 'https://' . l:url
  call netrw#BrowseX(l:url, 0)
endfunction

" Go to path for Go import
function! go#gf() abort
  let l:module_path = findfile('go.mod', '.;')
  if empty(l:module_path)
    return
  endif
  for l:line in readfile(l:module_path)
    let l:module = matchstr(l:line, '^module \zs.*\ze$')
    if !empty(l:module)
      let l:pat = '"' . l:module . '/\zs.*\ze"'
      let l:submodule = matchstr(getline('.'), l:pat)
      if empty(l:submodule)
        return
      endif
      let l:module_dir = fnamemodify(l:module_path, ':h')
      let l:path = l:module_dir . '/' . l:submodule
      execute 'edit' l:path
      return
    endif
  endfor
endfunction

