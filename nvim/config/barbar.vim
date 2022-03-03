let g:bufferline = {}

let g:bufferline.animation = v:false
let g:bufferline.auto_hide = v:true
let g:bufferline.add_in_buffer_number_order = v:true
let g:bufferline.closable = v:true
let g:bufferline.icons = 'numbers'
let g:bufferline.icon_separator_active = ''
let g:bufferline.icon_separator_inactive = ''
let g:bufferline.icon_close_tab = ' '
let g:bufferline.icon_close_tab_modified = ' '
let g:bufferline.insert_at_end = v:true
let g:bufferline.maximum_padding = 0
let g:bufferline.maximum_length = 100
let g:bufferline.no_name_title = '[No Name]'

nnoremap <silent> <Leader>[ :BufferPrevious<CR>
nnoremap <silent> <Leader>] :BufferNext<CR>

nnoremap <silent> <Leader>< :BufferMovePrevious<CR>
nnoremap <silent> <Leader>> :BufferMoveNext<CR>

nnoremap <silent> <Leader>1 :BufferGoto 1<CR>
nnoremap <silent> <Leader>2 :BufferGoto 2<CR>
nnoremap <silent> <Leader>3 :BufferGoto 3<CR>
nnoremap <silent> <Leader>4 :BufferGoto 4<CR>
nnoremap <silent> <Leader>5 :BufferGoto 5<CR>
nnoremap <silent> <Leader>6 :BufferGoto 6<CR>
nnoremap <silent> <Leader>7 :BufferGoto 7<CR>
nnoremap <silent> <Leader>8 :BufferGoto 8<CR>
nnoremap <silent> <Leader>9 :BufferLast<CR>

nnoremap <silent> <Leader>q :BufferClose<CR>
nnoremap <silent> <Leader>Q :BufferCloseAllButCurrent<CR>

function! g:plugin_highlights.barbar(set_highlight, colors) dict abort
  let l:background = a:colors.black

  let l:current = { 'bg': l:background, 'fg': a:colors.white }
  let l:modified = { 'bg': l:background, 'fg': a:colors.dark_yellow }
  let l:inactive = { 'bg': l:background, 'fg': a:colors.comment_grey }
  let l:tab = { 'bg': l:background, 'fg': a:colors.white }

  call a:set_highlight('BufferCurrent', l:current)
  call a:set_highlight('BufferCurrentIndex', l:current)
  call a:set_highlight('BufferCurrentMod', l:modified)

  call a:set_highlight('BufferVisible', l:inactive)
  call a:set_highlight('BufferVisibleIndex', l:inactive)
  call a:set_highlight('BufferVisibleMod', l:modified)

  call a:set_highlight('BufferInactive', l:inactive)
  call a:set_highlight('BufferInactiveIndex', l:inactive)
  call a:set_highlight('BufferInactiveMod', l:modified)

  call a:set_highlight('BufferTabpages', l:tab)
  call a:set_highlight('BufferTabpageFill', { 'bg': l:background })
endfunction
