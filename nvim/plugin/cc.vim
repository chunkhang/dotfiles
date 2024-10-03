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
"     call g:AddCcIncludeDirectory('include')
"     call g:AddCcIncludeDirectory('libft/include')
"   endif
function g:AddCcIncludeDirectory(dir) abort
  let l:inc_path = getcwd() . '/' . a:dir

  if !isdirectory(l:inc_path)
    echoerr 'cc.vim: Expected directory, but got: ' . l:inc_path
    return
  endif

  let g:ale_c_cc_options .= ' -I ' . l:inc_path
endfunction
