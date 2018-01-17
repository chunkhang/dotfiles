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

" Current working directory
set autochdir

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
set colorcolumn=80

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

" Explorer
let g:netrw_banner=0
let g:netrw_liststyle=3
set wildignore=.DS_Store,.cache,.git,__pycache__,*.rdb,*.pyc
let s:escape = 'substitute(escape(v:val, ".$~"), "*", ".*", "g")'
let g:netrw_list_hide=
    \ join(map(split(&wildignore, ','), '"^".' . s:escape . '. "/\\=$"'), ',')

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
nmap <silent> <leader>n :let @/=""<cr>

" Scrolling
nmap j gj
nmap k gk
nnoremap <leader>j 20j
nnoremap <leader>k 20k

" Close buffer
nnoremap <silent> <leader>q :BD<cr>
" Quit
nnoremap <silent> <leader>Q :q<cr>

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

" Indent
nnoremap < v<<esc>
nnoremap > v><esc>

" Git
nnoremap <leader>s :Gstatus<cr>
nnoremap <leader>c :Gcommit<cr>
nnoremap <leader>d :Gdiff<cr>

" Markdown preview
nnoremap <leader>m :call Vim_Markdown_Preview()<cr>

" Toggle syntax
nnoremap <silent> <leader>x :if exists('g:syntax_on') <Bar>
                  \     syntax off <Bar>
                  \ else <Bar>
                  \     syntax enable <Bar>
                  \ endif <cr>

" System clipboard
vnoremap <leader>y "*y
nnoremap <leader>p "*p

" Trailing whitespace
nnoremap <leader>t /\s\+$<cr>
nnoremap <leader>T :%s/\s\+$//e<cr>

" Emmet
let g:user_emmet_leader_key='<C-e>'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Markdown
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_no_default_key_mappings=1

" Markdown preview
let vim_markdown_preview_browser='firefox'
let vim_markdown_preview_github=1
let vim_markdown_preview_hotkey=''

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

" Syntastic
let g:syntastic_python_checkers=['flake8']

" Python
let g:python_highlight_operators=0
let g:python_highlight_indent_errors=0
let g:python_highlight_space_errors=0
let g:python_highlight_all=1
let g:python_highlight_file_headers_as_comments=1

" JavaScript
autocmd Filetype javascript set softtabstop=2 shiftwidth=2

" Ctrlp
let g:ctrlp_show_hidden=1

" Emmet
let g:user_emmet_install_global=0
autocmd FileType html,jinja,css EmmetInstall

" Commentary
autocmd FileType jinja setlocal commentstring={#\ %s\ #}
