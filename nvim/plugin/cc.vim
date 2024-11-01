" Name: cc.vim
" Description: C compiler plugins

if exists('g:loaded_cc')
  finish
endif
let g:loaded_cc = 1

" Add additional directory to include for cc
" Additionally, they can be also be called manually in .lvimrc file
" Example:
"   if !g:localvimrc_sourced_once
"     call g:AddCcIncludeDirectory(g:localvimrc_script_dir . '/include')
"   endif
function g:AddCcIncludeDirectory(dir) abort
  if !isdirectory(a:dir)
    echoerr 'cc.vim: Expected directory, but got: ' . a:dir
    return
  endif

  let g:ale_c_cc_options .= ' -I' . a:dir
endfunction
