if exists('b:did_ftplugin')
  finish
endif

nnoremap <buffer> <silent> gx :call go#gx()<CR>
nnoremap <buffer> <silent> gf :call go#gf()<CR>
