function! MyLightlineDirectory() abort
  return fnamemodify(getcwd(), ':t')
endfunction

function! MyLightlineGitBranch() abort
  let l:branch = fugitive#head()
  return strlen(l:branch) ? l:branch : ''
endfunction

function! MyLightlineFileType() abort
  return strlen(&filetype) ? &filetype : 'no ft'
endfunction

function! MyLightlineSpell() abort
  return &spell ? 'spell': ''
endfunction

let g:lightline = {}
let g:lightline.colorscheme = 'onedark'
let g:lightline.component_function = {
      \ 'cwd': 'MyLightlineDirectory',
      \ 'gitbranch': 'MyLightlineGitBranch',
      \ 'filetype': 'MyLightlineFileType',
      \ 'spell': 'MyLightlineSpell',
      \ }
let g:lightline.component_expand = {
      \ 'linter_checking': 'lightline#ale#checking',
      \ 'linter_warnings': 'lightline#ale#warnings',
      \ 'linter_errors': 'lightline#ale#errors'
      \ }
let g:lightline.component_type = {
      \ 'linter_checking': 'tabsel',
      \ 'linter_warnings': 'warning',
      \ 'linter_errors': 'error'
      \ }
let g:lightline.active = {
      \ 'left' : [ [ 'mode', 'paste' ],
      \            [ 'relativepath', 'readonly', 'modified' ],
      \            [ 'cwd', 'gitbranch' ] ],
      \ 'right': [ [ 'linter_checking', 'linter_errors', 'linter_warnings', 'lineinfo' ],
      \            [ 'percent' ],
      \            [ 'spell', 'filetype' ] ]
      \ }
let g:lightline.enable = { 'tabline': 0 }

let g:lightline#ale#indicator_checking = 'L'
let g:lightline#ale#indicator_warnings = 'W'
let g:lightline#ale#indicator_errors = 'E'
