let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_no_default_key_mappings = 1

function! s:HighlightCallback(set_highlight, colors) abort
  call a:set_highlight('htmlH1', { 'fg': a:colors.red })
  call a:set_highlight('htmlH2', { 'fg': a:colors.green })
  call a:set_highlight('htmlH3', { 'fg': a:colors.blue })
  call a:set_highlight('htmlH4', { 'fg': a:colors.purple })
  call a:set_highlight('htmlH5', { 'fg': a:colors.purple })
  call a:set_highlight('htmlH6', { 'fg': a:colors.purple })
endfunction
call g:AddHighlightCallback(function('<SID>HighlightCallback'))
