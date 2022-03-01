let g:javascript_plugin_flow = 1
let g:javascript_plugin_jsdoc = 1

function! s:HighlightCallback(set, colors) abort
  call a:set('jsDocTags', { 'fg': a:colors.cyan })
  call a:set('jsDocType', { 'fg': a:colors.yellow })
  call a:set('jsDocTypeNoParam', { 'fg': a:colors.yellow })
  call a:set('jsDocParam', { 'fg': a:colors.white })
endfunction
call g:AddHighlightCallback(function('<SID>HighlightCallback'))
