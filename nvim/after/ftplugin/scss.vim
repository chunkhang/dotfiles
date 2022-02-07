setlocal iskeyword+=-

nnoremap <buffer> <silent> gf :call scss#gf()<cCR>

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
else
  let b:undo_ftplugin = ''
endif
let b:undo_ftplugin .=
      \ 'setlocal iskeyword<' .
      \ ' | unmap <buffer> gf'
