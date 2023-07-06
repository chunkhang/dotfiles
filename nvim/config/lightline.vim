function! g:LightlineDirectory() abort
  return fnamemodify(getcwd(), ':t')
endfunction

function! g:LightlineGitBranch() abort
  let l:branch = FugitiveHead()
  return strlen(l:branch) ? l:branch : ''
endfunction

let g:lightline = {}
let g:lightline.colorscheme = 'onedark'
let g:lightline.component_function = {
      \ 'cwd': 'LightlineDirectory',
      \ 'git_branch': 'LightlineGitBranch',
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
      \ 'left' : [ [ 'mode' ],
      \            [ 'relativepath', 'readonly', 'modified' ],
      \            [ 'cwd', 'git_branch' ] ],
      \ 'right': [ [ 'linter_checking', 'linter_errors', 'linter_warnings', 'lineinfo' ],
      \            [ 'percent' ],
      \            [ 'spell', 'filetype' ] ]
      \ }
let g:lightline.enable = { 'tabline': 0 }
let g:lightline#ale#indicator_checking = '!'
let g:lightline#ale#indicator_warnings = ''
let g:lightline#ale#indicator_errors = ''

function! g:plugin_highlights.lightline(set_highlight, colors) dict abort
  call a:set_highlight('LightlineLeft_active_2', { 'fg': a:colors.white })
  call a:set_highlight('LightlineMiddle_active', { 'fg': a:colors.white })
  call a:set_highlight('LightlineRight_active_2', { 'fg': a:colors.white })
endfunction
