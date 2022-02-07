setlocal formatoptions-=o

nnoremap <buffer> <silent> gx :call vim#gx()<CR>

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
else
  let b:undo_ftplugin = ''
endif
let b:undo_ftplugin .=
      \ 'setlocal formatoptions<' .
      \ ' | silent! nunmap <buffer> gx'
