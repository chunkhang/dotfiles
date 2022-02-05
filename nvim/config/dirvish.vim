let g:dirvish_mode = ':sort | sort ,^.*[^/]$, r'
let g:dirvish_relative_paths = 1

augroup config_dirvish
  autocmd!
  autocmd FileType dirvish silent! nmap <buffer> q <Plug>(dirvish_quit)
augroup END
