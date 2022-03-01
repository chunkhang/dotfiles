let g:clap_layout = { 'relative': 'editor' }
let g:clap_no_matches_msg = 'No matches found'
let g:clap_insert_mode_only = v:true
let g:clap_open_preview = 'never'
let g:clap_prompt_format = '%provider_id%: '
let g:clap_enable_background_shadow = v:false

nnoremap <silent> <C-P> :Clap files ++finder=rg --files<CR>
nnoremap <silent> <C-B> :Clap buffers<CR>

let s:mouse = ''

function! s:DisableMouse() abort
  let s:mouse = &mouse
  set mouse=
endfunction

function! s:ResetMouse() abort
  let &mouse = s:mouse
endfunction

augroup config_clap
  autocmd!
  autocmd User ClapOnEnter call <SID>DisableMouse()
  autocmd User ClapOnExit  call <SID>ResetMouse()
  autocmd FileType clap_input inoremap <buffer> <C-P> <NOP>
  autocmd FileType clap_input inoremap <buffer> <C-N> <NOP>
augroup END

function! g:plugin_highlights.clap(set_highlight, colors) dict abort
  call a:set_highlight('ClapSpinner', {'bg': a:colors.cursor_grey, 'fg': a:colors.blue })
  call a:set_highlight('ClapSearchText', {'bg': a:colors.cursor_grey })
  call a:set_highlight('ClapInput', {'bg': a:colors.cursor_grey })
  call a:set_highlight('ClapDisplay', {'bg': a:colors.cursor_grey })
  call a:set_highlight('ClapCurrentSelectionSign', {'bg': a:colors.menu_grey, 'fg': a:colors.white })
  call a:set_highlight('ClapCurrentSelection', {'bg': a:colors.menu_grey })
  call a:set_highlight('ClapSelectedSign', {'fg': a:colors.yellow })
  call a:set_highlight('ClapSelected', {'fg': a:colors.yellow })
  call a:set_highlight('ClapProviderAbout', {'fg': a:colors.white })
  call a:set_highlight('ClapProviderId', {'fg': a:colors.purple })
  call a:set_highlight('ClapProviderColon', {'fg': a:colors.purple })
  call a:set_highlight('ClapFile', {'fg': a:colors.white })
  call a:set_highlight('ClapBuffersNumberBracket', {'fg': a:colors.white })
  call a:set_highlight('ClapBuffersNumber', {'fg': a:colors.white })
  call a:set_highlight('ClapBuffersFsize', {'fg': a:colors.white })
  call a:set_highlight('ClapBuffersFname', {'fg': a:colors.white })
  let g:clap_fuzzy_match_hl_groups = [[a:colors.red.cterm, a:colors.red.gui]]
endfunction
