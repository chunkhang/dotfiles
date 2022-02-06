if exists('b:did_indent')
  finish
endif
let b:did_indent = 1

if &filetype ==# 'xml.plist'
  setlocal noexpandtab
  setlocal shiftwidth=0
endif
