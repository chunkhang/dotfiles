setlocal formatoptions-=o
setlocal keywordprg=~/.scripts/docs/duckduckgo

nnoremap <buffer> <silent> gf :call javascript#gf()<CR>

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
else
  let b:undo_ftplugin = ''
endif
let b:undo_ftplugin .=
      \ 'setlocal formatoptions< keywordprg<' .
      \ ' | silent! nunmap <buffer> gf'
