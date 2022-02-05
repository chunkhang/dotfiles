if exists('b:did_ftplugin')
  finish
endif

setlocal iskeyword+=-

nnoremap <buffer> <silent> gf :call scss#gf()<cCR>
