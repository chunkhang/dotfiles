if exists('b:did_indent')
  finish
endif
let b:did_indent = 1

if &filetype ==# 'javascript.mdx'
  setlocal shiftwidth=2
endif
