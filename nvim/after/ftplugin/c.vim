setlocal noexpandtab
setlocal cindent
setlocal tabstop=4
setlocal shiftwidth=4
setlocal keywordprg=man\ 3

let b:SuperTabDisabled = 1

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
else
  let b:undo_ftplugin = ''
endif
let b:undo_ftplugin .=
      \ 'setlocal expandtab< cindent< tabstop< shiftwidth< keywordprg<' .
      \ ' | unlet! b:SuperTabDisabled'
