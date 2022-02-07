setlocal shiftwidth=2
setlocal tabstop=2

if exists('b:undo_indent')
  let b:undo_indent .= ' | '
else
  let b:undo_indent = ''
endif
let b:undo_indent .=
      \ 'setlocal shiftwidth<' .
      \ ' | setlocal tabstop<'
