" Pathogen
execute pathogen#infect()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

" Current working directory
set autochdir

" Remove auto comment
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Spelling language
set spelllang=en_gb

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" User Interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Line numbers
set number
set relativenumber

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
set shortmess+=I

" Truncate message to avoid hit enter
set shortmess+=T

" Explorer
let g:netrw_banner=0
let g:netrw_liststyle=3
set wildignore=.DS_Store,.cache,.git,__pycache__,*.rdb,*.pyc,.pytest_cache
set wildignore+=*.class,*/node_modules/*,*/dist/*,*/releases/*,*/target/*
set wildignore+=.g8,*/logs/*,*/phaser/*,*/_site/*,*/.sass-cache/*
set wildignore+=*/.jekyll-cache/*,.ctrlp,.tags,*/build/*,*/Pods/*
let s:escape='substitute(escape(v:val, ".$~"), "*", ".*", "g")'
let g:netrw_list_hide=
    \ join(map(split(&wildignore, ','), '"^".' . s:escape . '. "/\\=$"'), ',')

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax highlighting
syntax on

" Encoding
set encoding=utf8

" Color scheme
colorscheme base16-eighties
set termguicolors

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tabs
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
autocmd FileType html,jinja,vue,scss set softtabstop=2 shiftwidth=2
autocmd FileType javascript,coffee,json set softtabstop=2 shiftwidth=2
autocmd FileType sbt,play2-conf set softtabstop=2 shiftwidth=2
autocmd FileType yaml,markdown set softtabstop=2 shiftwidth=2
autocmd FileType proto set softtabstop=2 shiftwidth=2
autocmd FileType go set softtabstop=4 shiftwidth=4

" Indent
set autoindent

" Highlight whitespaces
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.

" Backspace
set backspace=indent,eol,start

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Leader key
let mapleader=" "

" Configuration
nnoremap <leader>V :edit ~/.vimrc<cr>
nnoremap <silent> <leader>v :source ~/.vimrc<cr>
    \ :echo 'Source configuration'<cr>

" Remove search highlighting
nnoremap <silent> <leader>/ :noh<cr>
    \ :echo 'Remove search highlighting'<cr>

" Scrolling
nmap j gj
nmap k gk
nnoremap <leader>j 20j
nnoremap <leader>k 20k
vnoremap <leader>j 20j
vnoremap <leader>k 20k

" Close buffer
nnoremap <silent> <leader>q :BD<cr>

" Write buffer
nnoremap <leader>w :w<cr>
nnoremap <leader>W :wa<cr>

" Switch windows
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
" Fix <C-j>: https://stackoverflow.com/a/31502538
augroup vimrc
    au!
    au VimEnter * unmap <C-j>
    au VimEnter * noremap <C-j> <C-w>j
augroup END

" Split
nnoremap <leader><right> :vs<cr>
nnoremap <leader><down> :sp<cr>
nnoremap <leader><left> :set splitright&<cr>:vs<cr>:set splitright<cr>
nnoremap <leader><up> :set splitbelow&<cr>:sp<cr>:set splitbelow<cr>

" Override
nnoremap ! :<up>!

" Disable keys in normal mode
nnoremap <backspace> <nop>
nnoremap <space> <nop>
nnoremap <cr> <nop>

" Indent
nnoremap < v<<esc>
    \ :echo 'Dedent'<cr>
nnoremap > v><esc>
    \ :echo 'Indent'<cr>

" Markdown preview
nnoremap <silent> <leader>m :call Vim_Markdown_Preview()<cr>
    \ :echo 'Preview markdown'<cr>

" Toggle syntax
nnoremap <silent> <leader>x :if exists('g:syntax_on') <Bar>
                  \     syntax off <Bar>
                  \ else <Bar>
                  \     syntax enable <Bar>
                  \ endif <cr>
    \ :echo 'Toggle syntax'<cr>

" System clipboard
nnoremap <leader>Y "*Y
    \ :echo 'Copy to system clipboard'<cr>
vnoremap <leader>y "*y
    \ :echo 'Copy to system clipboard'<cr>
nnoremap <leader>p "*p
    \ :echo 'Paste from system clipboard'<cr>
vnoremap <leader>p "*p
    \ :echo 'Paste from system clipboard'<cr>

" Trailing whitespace
nnoremap <leader>t /\s\+$<cr>
    \ :echo 'Search trailing whitespace'<cr>
nnoremap <leader>T :%s/\s\+$//e<cr>:let @/=""<cr>
    \ :echo 'Trim trailing whitespace'<cr>

" Emmet
let g:user_emmet_leader_key='<C-e>'

" Cursor column
nnoremap <silent> <leader>C :setlocal cursorcolumn!<cr>
    \ :echo 'Toggle cursor column'<cr>

" Select all
nnoremap <leader>a ggVG
vnoremap <leader>a <esc>ggVG

" Toggle spell check
nnoremap <silent> <leader>s :setlocal spell!<cr>
    \ :echo 'Toggle spell check'<cr>

" Re-edit
nnoremap <silent> <leader>r :e<cr>

" CtrlSF
nmap     <C-F>f <Plug>CtrlSFPrompt
nmap     <C-F>w <Plug>CtrlSFCwordPath
nmap     <C-F>n <Plug>CtrlSFPwordPath
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>

" ALE
nmap <silent> [a <Plug>(ale_previous_wrap)
nmap <silent> ]a <Plug>(ale_next_wrap)

" Ctrlp
nnoremap <C-b> :CtrlPBuffer<CR>

" Nerdtree
map <C-o> :NERDTreeToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
let g:lightline={}
let g:lightline.colorscheme='wombat'
let g:lightline.component_function={
      \ 'gitbranch': 'fugitive#head',
      \ 'filetype': 'MyFiletype',
      \ 'fileformat': 'MyFileformat'
      \ }
let g:lightline.component_expand={
      \ 'linter_checking': 'lightline#ale#checking',
      \ 'linter_warnings': 'lightline#ale#warnings',
      \ 'linter_errors': 'lightline#ale#errors'
      \ }
let g:lightline.component_type={
      \ 'linter_checking': 'left',
      \ 'linter_warnings': 'warning',
      \ 'linter_errors': 'error'
      \ }
let g:lightline.active={
      \ 'left' : [ [ 'mode', 'paste' ],
      \            [ 'gitbranch', 'readonly', 'relativepath', 'modified' ] ],
      \ 'right': [ [ 'linter_checking', 'linter_errors', 'linter_warnings' ],
      \            [ 'lineinfo' ],
      \            [ 'gutentags', 'filetype', 'percent' ] ]
      \ }
let g:lightline#ale#indicator_checking="\uf110 "
let g:lightline#ale#indicator_warnings="\uf071 "
let g:lightline#ale#indicator_errors="\uf05e "
function! MyFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ?
      \ &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction
function! MyFileformat()
    return winwidth(0) > 70 ?
      \ (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

" Git gutter
set updatetime=250
set signcolumn=yes
let g:gitgutter_max_signs=1000

" Python
let g:python_highlight_operators=0
let g:python_highlight_indent_errors=0
let g:python_highlight_space_errors=0
let g:python_highlight_all=1
let g:python_highlight_file_headers_as_comments=1

" Ctrlp
let g:ctrlp_show_hidden=1
let g:ctrlp_root_markers=['.ctrlp']

" Emmet
let g:user_emmet_install_global=0
autocmd FileType html,jinja,css,scss,coffee,javascript EmmetInstall

" Commentary
autocmd FileType jinja setlocal commentstring={#\ %s\ #}
autocmd FileType vue setlocal commentstring=\/\/\ %s
autocmd FileType sbt setlocal commentstring=\/\/\ %s
autocmd FileType hocon setlocal commentstring=#\ %s

" CSS
augroup VimCSS3Syntax
  autocmd!

  autocmd FileType css silent! setlocal iskeyword+=- space-between
augroup END

" CtrlSF
let g:ctrlsf_case_sensitive='yes'
let g:ctrlsf_default_root='project'
let g:ctrlsf_position='right'

" ALE
let g:ale_sign_error='●'
let g:ale_sign_warning='.'
let g:ale_lint_on_enter=0
let g:ale_lint_on_text_changed='never'
let g:ale_linters={
    \ 'javascript': ['eslint']
    \ }
let g:ale_javascript_eslint_executable='npx eslint'

" Local vimrc
let g:localvimrc_persistent=1

" Gutentags
let g:gutentags_ctags_tagfile='.tags'

" Signature
highlight SignatureMarkText guifg=#f2777a

" Nerdtree
let g:NERDTreeShowHidden=1
let g:NERDTreeLimitedSyntax=1
let g:NERDTreeRespectWildIgnore=1
let g:NERDTreeIgnore=['node_modules/*','\.vscode','\.tags\.*','\build/*','\Pods/*']
let g:NERDTreeMinimalUI=1

" Go
let g:go_fmt_fail_silently=1

" Bufkill
let g:BufKillCreateMappings=0
