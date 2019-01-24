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

" Remove auto comment
aug vimrc_remove_auto_comment
    au!
    au FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
aug END

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

" Netrw
let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_winsize=20
let g:netrw_browse_split=4

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax highlighting
syntax on

" Encoding
set encoding=utf-8
scriptencoding utf-8

" Color scheme
colorscheme base16-eighties
set termguicolors

let g:is_bash=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tabs
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
aug vimrc_tabs
    au!
    au FileType html,javascript,json,yaml set softtabstop=2 shiftwidth=2
    au FileType jinja,vue,scss,coffee set softtabstop=2 shiftwidth=2
    au FileType sbt,play2-conf set softtabstop=2 shiftwidth=2
    au FileType markdown,proto set softtabstop=2 shiftwidth=2
    au FileType go set softtabstop=4 shiftwidth=4
    au FileType snippets set expandtab
aug END

" Indent
set autoindent

" Highlight whitespaces
set list
set listchars=tab:\|\ ,trail:.,extends:#,nbsp:.

" Backspace
set backspace=indent,eol,start

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Leader key
let mapleader=' '

" Configuration
nnoremap <leader>v :edit ~/.vimrc<cr>
nnoremap <silent> <leader>V :source ~/.vimrc<cr>
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
aug vimrc_switch_windows
    au!
    au VimEnter * unmap <C-j>
    au VimEnter * noremap <C-j> <C-w>j
aug END

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

" Column 80
nnoremap <silent> <leader>c :execute 'setlocal colorcolumn='
            \ . (&colorcolumn == '' ? '80' : '')<cr>
            \ :echo 'Toggle column 80'<cr>

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
nnoremap <C-F>t :CtrlSFToggle<cr>
inoremap <C-F>t <Esc>:CtrlSFToggle<cr>

" ALE
nmap <silent> [a <Plug>(ale_previous_wrap)
nmap <silent> ]a <Plug>(ale_next_wrap)

" Ultisnips
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'
nnoremap <leader>u :edit ~/.vim/ultisnips/

" Buftabline
nmap <leader>1 <Plug>BufTabLine.Go(1)
nmap <leader>2 <Plug>BufTabLine.Go(2)
nmap <leader>3 <Plug>BufTabLine.Go(3)
nmap <leader>4 <Plug>BufTabLine.Go(4)
nmap <leader>5 <Plug>BufTabLine.Go(5)
nmap <leader>6 <Plug>BufTabLine.Go(6)
nmap <leader>7 <Plug>BufTabLine.Go(7)
nmap <leader>8 <Plug>BufTabLine.Go(8)
nmap <leader>9 <Plug>BufTabLine.Go(9)
nmap <leader>0 <Plug>BufTabLine.Go(10)

" Netrw
nnoremap <silent> <C-x> :Lexplore<cr>

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

" Ctrlp
let g:ctrlp_show_hidden=1
let g:ctrlp_root_markers=['.ctrlp']
let g:ctrlp_use_caching=0
if executable('ag')
    let g:ctrlp_user_command='ag %s -l --nocolor -g "" --hidden --ignore-dir .git'
endif

" Emmet
let g:user_emmet_install_global=0
aug vimrc_emmet
    au!
    au FileType html,jinja,css,scss,coffee,javascript EmmetInstall
aug END

" Commentary
aug vimrc_commentary
    au!
    au FileType jinja setlocal commentstring={#\ %s\ #}
    au FileType vue,sbt setlocal commentstring=\/\/\ %s
    au FileType hocon setlocal commentstring=#\ %s
aug END

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
            \ 'javascript': ['eslint'],
            \ 'python': ['flake8']
            \ }
let g:ale_javascript_eslint_executable='npx eslint'

" Local vimrc
let g:localvimrc_persistent=1

" Gutentags
let g:gutentags_ctags_tagfile='.tags'

" Signature
highlight link SignatureMarkText DiffDelete

" Go
let g:go_fmt_fail_silently=1

" Bufkill
let g:BufKillCreateMappings=0

" Ultisnips
let g:UltiSnipsEditSplit='context'
" https://github.com/SirVer/ultisnips/issues/593#issuecomment-361338769
aug vimrc_ultisnips
    au!
    au VimEnter * au! UltiSnips_AutoTrigger
aug END

" Buftabline
let g:buftabline_show=1
let g:buftabline_numbers=2
let g:buftabline_indicators=1
highlight link BufTabLineCurrent LightlineLeft_normal_1
highlight link BufTabLineActive LightlineRight_normal_2
highlight link BufTabLineHidden LightlineRight_normal_2
