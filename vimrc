""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASICS
" Options that must be set, and memorized
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set number

set shiftwidth=4
set tabstop=4

set autoindent

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EXTRAS
" Options that are good to have
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nobackup

set cursorline

set list
set listchars=tab:\|\ ,trail:.

set hlsearch
set showmatch
set smartcase

set wildmenu

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS
" To install a plugin:
" $ mkdir -p ~/.vim/pack/vendor/start
" $ git clone <url> ~/.vim/pack/vendor/start
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" https://github.com/chunkhang/norminette-ale
" https://github.com/dense-analysis/ale
" https://github.com/tpope/vim-surround

let g:ale_linters_explicit = 1
let g:ale_linters = {
      \ 'c': ['cc', 'norminette']
  \ }
let g:ale_c_cc_options = '-Wall -Wextra -Werror'

nmap [e <Plug>(ale_previous_wrap_error)
nmap ]e <Plug>(ale_next_wrap_error)
nmap [w <Plug>(ale_previous_wrap_warning)
nmap ]w <Plug>(ale_next_wrap_warning)
