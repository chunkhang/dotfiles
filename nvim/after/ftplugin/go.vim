nnoremap <buffer> <silent> gx :call go#gx()<CR>
nnoremap <buffer> <silent> gf :call go#gf()<CR>

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
else
  let b:undo_ftplugin = ''
endif
let b:undo_ftplugin .=
      \ 'silent! nunmap <buffer> gx' .
      \ ' | silent! nunmap <buffer> gf'
