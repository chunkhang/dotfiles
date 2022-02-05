if exists('b:did_ftplugin')
  finish
endif

set keywordprg=~/.scripts/docs/duckduckgo

nnoremap <buffer> <silent> gf :call javascript#gf()<CR>
