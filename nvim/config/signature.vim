function! s:HighlightCallback(set, colors) abort
  call a:set('SignatureMarkText', {'fg': a:colors.blue })
endfunction
call g:AddHighlightCallback(function('<SID>HighlightCallback'))
