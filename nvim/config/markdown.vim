let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_no_default_key_mappings = 1
let g:vim_markdown_folding_disabled = 1

augroup config_markddown
  autocmd!
  autocmd BufEnter *.md syntax clear mkdLineBreak
augroup END

function! g:plugin_highlights.markdown(set_highlight, colors) dict abort
  call a:set_highlight('htmlH1', { 'fg': a:colors.red })
  call a:set_highlight('htmlH2', { 'fg': a:colors.purple })
  call a:set_highlight('htmlH3', { 'fg': a:colors.blue })
  call a:set_highlight('htmlH4', { 'fg': a:colors.cyan })
  call a:set_highlight('htmlH5', { 'fg': a:colors.red })
  call a:set_highlight('htmlH6', { 'fg': a:colors.red })
endfunction
