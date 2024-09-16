" Name: os.vim
" Description: MacOS-specific configuration

if exists('g:loaded_os')
  finish
endif
let g:loaded_os = 1

if has('linux')
  let g:clipboard = {
        \ 'name': 'xclip',
        \ 'copy': {
        \    '+': 'xclip -selection clipboard',
        \    '*': 'xclip -selection clipboard',
        \  },
        \ 'paste': {
        \    '+': 'xclip -selection clipboard -out',
        \    '*': 'xclip -selection clipboard -out',
        \ },
        \ 'cache_enabled': 1,
        \ }

  let g:netrw_browsex_viewer = 'gio open'
endif
