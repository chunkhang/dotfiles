" Check all possible extensions
" Return whether path with extension was opened successfully
function! javascript#open(path) abort
  let l:exts = ['', '.js', '.jsx', '/index.js', '/index.jsx']
  for l:ext in l:exts
    let l:candidate = a:path . l:ext
    if filereadable(l:candidate)
      execute 'edit' l:candidate
      return v:true
    endif
  endfor
  return v:false
endfunction

" Go to path for JavaScript import
function! javascript#gf() abort
  " Line must contain `require` or `import`
  let l:line = getline('.')
  if empty(matchstr(l:line, '\(import\|from\|require\)'))
    return
  endif

  " Extract matched import path
  let l:match = matchstr(l:line, "'\\zs.*\\ze'")

  " Resolve import aliases
  let l:imports = [l:match]
  let l:aliases = {
        \ '\~': ['.'],
        \ }
  for l:alias in items(l:aliases)
    let l:alias_from = l:alias[0]
    for l:alias_to in l:alias[1]
      if empty(matchstr(l:match, l:alias_from))
        continue
      endif
      let l:import = substitute(l:match, l:alias_from, l:alias_to, '')
      let l:imports = add(l:imports, l:import)
    endfor
  endfor

  for l:import in l:imports
    " Import is relative to current working directory
    if javascript#open(l:import)
      break
    endif
    " Import is relative to directory of current file
    let l:dir = expand('%:h')
    let l:rel = fnamemodify(l:dir . '/' . l:import, ':.')
    if javascript#open(l:rel)
      break
    endif
  endfor
endfunction
