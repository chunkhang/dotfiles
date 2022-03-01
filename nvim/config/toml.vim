function! s:HighlightCallback(set_highlight, colors) abort
  call a:set_highlight('tomlTable', { 'fg': a:colors.blue })
endfunction
call g:AddHighlightCallback(function('<SID>HighlightCallback'))
