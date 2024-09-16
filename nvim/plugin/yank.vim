" Name: yank.vim
" Description: Yank-specific configuration

if exists('g:loaded_yank')
  finish
endif
let g:loaded_yank = 1

" Enable highlight on yank
augroup plugin_yank
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank {timeout=500}
augroup END
