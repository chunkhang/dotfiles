let g:javascript_plugin_flow = 1
let g:javascript_plugin_jsdoc = 1

function! g:plugin_highlights.jsx_improve(set_highlight, colors) dict abort
  call a:set_highlight('jsDocTags', { 'fg': a:colors.cyan })
  call a:set_highlight('jsDocType', { 'fg': a:colors.yellow })
  call a:set_highlight('jsDocTypeNoParam', { 'fg': a:colors.yellow })
  call a:set_highlight('jsDocParam', { 'fg': a:colors.white })
endfunction
