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

function! s:HighlightCallback(set, colors) abort
  call a:set('ClapSpinner', {'bg': a:colors.cursor_grey, 'fg': a:colors.blue })
  call a:set('ClapSearchText', {'bg': a:colors.cursor_grey })
  call a:set('ClapInput', {'bg': a:colors.cursor_grey })
  call a:set('ClapDisplay', {'bg': a:colors.cursor_grey })
  call a:set('ClapCurrentSelectionSign', {'bg': a:colors.menu_grey, 'fg': a:colors.white })
  call a:set('ClapCurrentSelection', {'bg': a:colors.menu_grey })
  call a:set('ClapSelectedSign', {'fg': a:colors.yellow })
  call a:set('ClapSelected', {'fg': a:colors.yellow })
  call a:set('ClapProviderAbout', {'fg': a:colors.white })
  call a:set('ClapProviderId', {'fg': a:colors.purple })
  call a:set('ClapProviderColon', {'fg': a:colors.purple })
  call a:set('ClapFile', {'fg': a:colors.white })
  call a:set('ClapBuffersNumberBracket', {'fg': a:colors.white })
  call a:set('ClapBuffersNumber', {'fg': a:colors.white })
  call a:set('ClapBuffersFsize', {'fg': a:colors.white })
  call a:set('ClapBuffersFname', {'fg': a:colors.white })
  let g:clap_fuzzy_match_hl_groups = [[a:colors.red.cterm, a:colors.red.gui]]
endfunction
call g:AddHighlightCallback(function('<SID>HighlightCallback'))
