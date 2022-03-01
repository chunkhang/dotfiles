function! g:plugin_highlights.jsx_typescript(set_highlight, colors) dict abort
  call a:set_highlight('typescriptParens', { 'fg': a:colors.white })
  call a:set_highlight('typescriptStorageClass', { 'fg': a:colors.purple })
  call a:set_highlight('typescriptInterpolationDelimiter', { 'fg': a:colors.red })
  call a:set_highlight('typescriptNull', { 'fg': a:colors.dark_yellow })
  call a:set_highlight('typescriptType', { 'fg': a:colors.dark_yellow })
  call a:set_highlight('typescriptGlobalObjects', { 'fg': a:colors.yellow })
  call a:set_highlight('typescriptDeprecated', { 'fg': a:colors.blue })
  call a:set_highlight('typescriptBranch', { 'fg': a:colors.red })
  call a:set_highlight('typescriptLogicSymbols', { 'fg': a:colors.purple })
  call a:set_highlight('ReactLifeCycleMethods', { 'fg': a:colors.blue })
  call a:set_highlight('ReduxKeywords', { 'fg': a:colors.white })
  call a:set_highlight('tsxCloseTag', { 'fg': a:colors.white })
endfunction
