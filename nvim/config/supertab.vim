let g:SuperTabDefaultCompletionType = 'context'
let g:SuperTabContextFileCompletionDisabled = 1
let g:SuperTabClosePreviewOnPopupClose = 1

augroup config_supertab
  autocmd!
  autocmd FileType *
    \ if &omnifunc != '' |
    \   call SuperTabChain(&omnifunc, "<c-p>") |
    \ endif
augroup END
