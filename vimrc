" Pathogen
execute pathogen#infect()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Lines of history
set history=1000

" Buffer
set hidden

" Filetypes
filetype plugin on
filetype indent on
au FileType javascript setlocal softtabstop=2 shiftwidth=2

" Disable backup
set nobackup
set noswapfile

" Autoread
set autoread

" Escape to normal mode faster
set timeoutlen=1000
set ttimeoutlen=0

" Autosave
:au FocusLost * :wa

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" User Interface
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Line numbers
set number

" Scrolling
set scrolloff=10

" Commands
set wildmenu
set showcmd

" Position
set ruler
set cursorline
set colorcolumn=81

" Searching
set ignorecase
set smartcase
set hlsearch
set incsearch

" Matching braces, brackets and parentheses
set showmatch

" Bell
set belloff=all

" Mouse
set mouse=a

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors and Fonts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax highlighting
syntax on

" Encoding
set encoding=utf8

" Color scheme
colorscheme base16-eighties
set termguicolors

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tabs
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Indent
set autoindent

" Highlight whitespaces
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.

" Backspace 
set backspace=indent,eol,start

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Leader key
let mapleader=" "

" Source configuration
map <silent> <leader>s :source ~/.vimrc<cr><leader>/

" Clear search pattern
nmap <silent> <leader>/ :let @/=""<cr>

" Switch windows
noremap <C-h> <C-W>h
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-l> <C-W>l

" Override
nnoremap ! :<up>!

" Disable keys in normal mode
nnoremap <backspace> <nop>
nnoremap <space> <nop>
nnoremap <cr> <nop>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Markdown
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_no_default_key_mappings=1

" Lightline
set laststatus=2
set noshowmode
let g:lightline={
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'relativepath', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

" Git gutter
set updatetime=250
set signcolumn=yes

" Vinegar
noremap <leader>e :Explore<cr>
let g:netrw_liststyle=3
set wildignore=.DS_Store,.cache,.git,__pycache__,*.rdb

" Syntastic
nnoremap <silent> <leader>l :SyntasticCheck<cr>
let g:syntastic_python_checkers=['flake8']
