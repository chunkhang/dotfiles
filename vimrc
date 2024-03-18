""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OPTIONS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set number

set cindent
set tabstop=4
set shiftwidth=4

set nobackup

set mouse=a

set cursorline

set list
set listchars=tab:\|\ ,trail:.

set hlsearch
set incsearch
set showmatch
set smartcase

set wildmenu

set keywordprg=man\ 3

let g:c_syntax_for_h = 1
let g:c_no_curly_error = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS
" $ mkdir -p ~/.vim/pack/vendor/start
" $ cd ~/.vim/pack/vendor/start
" $ git clone <url>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" https://github.com/chunkhang/norminette-ale
" https://github.com/dense-analysis/ale
" https://github.com/jiangmiao/auto-pairs
" https://github.com/tpope/vim-surround

let g:ale_linters_explicit = 1
let g:ale_linters = {
      \ 'c': ['cc', 'norminette']
  \ }
let g:ale_c_cc_options = '-Wall -Wextra -Werror'
let g:ale_c_norminette_options = ' -R CheckForbiddenSourceHeader -R CheckDefine'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MAPPINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nmap [e <Plug>(ale_previous_wrap_error)
nmap ]e <Plug>(ale_next_wrap_error)
nmap [w <Plug>(ale_previous_wrap_warning)
nmap ]w <Plug>(ale_next_wrap_warning)
