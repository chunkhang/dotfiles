function! g:plugin_highlights.signature(set_highlight, colors) dict abort
  call a:set_highlight('SignatureMarkText', { 'fg': a:colors.gutter_fg_grey })
endfunction
