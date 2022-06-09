setlocal omnifunc=ale#completion#OmniFunc

nnoremap <buffer> <silent> K :ALEHover<CR>
nnoremap <buffer> <silent> gr :ALEFindReferences<CR>
nnoremap <buffer> <silent> <C-]> :ALEGoToDefinition<CR>
nnoremap <buffer> <silent> <Leader><Space> :ALECodeAction<CR>
nnoremap <buffer> <silent> gf :call typescript#gf()<CR>

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
else
  let b:undo_ftplugin = ''
endif
let b:undo_ftplugin .=
      \ 'setlocal omnifunc<' .
      \ ' | silent! nunmap <buffer> K' .
      \ ' | silent! nunmap <buffer> gr' .
      \ ' | silent! nunmap <buffer> <C-]>' .
      \ ' | silent! nunmap <buffer> <Leader><Space>'
