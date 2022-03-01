let g:UltiSnipsSnippetDirectories = [stdpath('config') . '/ultisnips']
let g:UltiSnipsSnippetStorageDirectoryForUltiSnipsEdit = stdpath('config') . '/ultisnips'
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

" Fix ultisnips lag issue
" https://github.com/SirVer/ultisnips/issues/593#issuecomment-361338769
augroup config_ultisnips
  autocmd!
  autocmd VimEnter * autocmd! UltiSnips_AutoTrigger
augroup END

nnoremap <silent> <Leader>u :UltiSnipsEdit<CR>

function! s:HighlightCallback(set_highlight, colors) abort
  call a:set_highlight('snipLeadingSpaces', {'fg': a:colors.black })
endfunction
call g:AddHighlightCallback(function('<SID>HighlightCallback'))
