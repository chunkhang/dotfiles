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
autocmd FileType javascript setlocal softtabstop=2 shiftwidth=2

" Disable backup
set nobackup
set noswapfile

" Autoread
set autoread

" Escape to normal mode faster
set timeoutlen=1000
set ttimeoutlen=0

" Autosave
autocmd FocusLost * :wa

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

" Splitting
set splitbelow
set splitright

" Disable introduction
set shortmess=I

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

" Edit configuration
nnoremap <leader>v :edit ~/.vimrc<cr>

" Source configuration
nnoremap <silent> <leader>r :source ~/.vimrc<cr><esc>

" Clear search pattern
nmap <silent> <leader>/ :let @/=""<cr>

" Close buffer
nnoremap <leader>q :bd<cr>

" Open shell
nnoremap <leader>s :shell<cr>

" Write buffer
nnoremap <leader>w :write<cr>

" Switch windows
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l

" Override
nnoremap ! :<up>!

" Disable keys in normal mode
nnoremap <backspace> <nop>
nnoremap <space> <nop>
nnoremap <cr> <nop>

" Explorer
nnoremap <leader>e :Explore<cr>

" Linter
nnoremap <silent> <leader>l :SyntasticCheck<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Markdown
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_no_default_key_mappings=1

" Markdown preview
let vim_markdown_preview_browser='firefox'
let vim_markdown_preview_github=1
let vim_markdown_preview_hotkey='<C-m>'

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
let g:netrw_liststyle=3
set wildignore=.DS_Store,.cache,.git,__pycache__,*.rdb,*.pyc

" Syntastic
let g:syntastic_python_checkers=['flake8']

" Python
let g:python_highlight_operators=0
let g:python_highlight_indent_errors=0
let g:python_highlight_space_errors=0
let g:python_highlight_all=1
let g:python_highlight_file_headers_as_comments=1
autocmd Filetype python :Python3Syntax
