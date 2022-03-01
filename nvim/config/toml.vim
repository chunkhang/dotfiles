function! g:plugin_highlights.toml(set_highlight, colors) dict abort
  call a:set_highlight('tomlTable', { 'fg': a:colors.blue })
endfunction
