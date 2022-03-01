let g:bufferline = {}

let g:bufferline.animation = v:false
let g:bufferline.auto_hide = v:true
let g:bufferline.add_in_buffer_number_order = v:true
let g:bufferline.closable = v:true
let g:bufferline.icons = 'numbers'
let g:bufferline.icon_separator_active = ' '
let g:bufferline.icon_separator_inactive = ' '
let g:bufferline.icon_close_tab = ''
let g:bufferline.icon_close_tab_modified = '+'
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

function! s:HighlightCallback(set, colors) abort
  call a:set('BufferCurrent', {'bg': a:colors.black, 'fg': a:colors.white })
  call a:set('BufferCurrentIndex', {'bg': a:colors.black, 'fg': a:colors.white })
  call a:set('BufferCurrentMod', {'bg': a:colors.black, 'fg': a:colors.white })
  call a:set('BufferVisible', {'bg': a:colors.black, 'fg': a:colors.comment_grey })
  call a:set('BufferVisibleIndex', {'bg': a:colors.black, 'fg': a:colors.comment_grey })
  call a:set('BufferVisibleMod', {'bg': a:colors.black, 'fg': a:colors.comment_grey })
  call a:set('BufferVisibleSign', {'bg': a:colors.black, 'fg': a:colors.comment_grey })
  call a:set('BufferInactive', {'bg': a:colors.black, 'fg': a:colors.comment_grey })
  call a:set('BufferInactiveIndex', {'bg': a:colors.black, 'fg': a:colors.comment_grey })
  call a:set('BufferInactiveMod', {'bg': a:colors.black, 'fg': a:colors.comment_grey })
  call a:set('BufferInactiveSign', {'bg': a:colors.black, 'fg': a:colors.comment_grey })
  call a:set('BufferTabpages', {'bg': a:colors.black, 'fg': a:colors.white })
  call a:set('BufferTabpageFill', {'bg': a:colors.black })
endfunction
call g:AddHighlightCallback(function('<SID>HighlightCallback'))
