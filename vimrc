" Pathogen
execute pathogen#infect()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Lines of history
set history=1000

" Buffers
set hidden
aug vimrc_remove_empty_buffer
  au!
  au BufWinEnter * call MyCleanEmptyBuffers()
aug END
" https://redd.it/1a4yf1
function! MyCleanEmptyBuffers()
  let buffers = filter(
        \ range(1, bufnr('$')),
        \ 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val) < 0 &&
        \ (getbufline(v:val, 1, "$") == [""])'
        \ )
  if !empty(buffers)
    exe 'bd '.join(buffers, ' ')
  endif
endfunction

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
  au FileType * setlocal formatoptions-=cro
  " Exceptions
  au FileType markdown setlocal formatoptions+=cro
aug END

" Spelling language
set spelllang=en_gb

" Shell
set shell=/usr/local/bin/zsh

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax highlighting
syntax on
let g:is_bash=1

" Encoding
set encoding=utf-8
scriptencoding utf-8

" Color scheme
if (empty($TMUX))
  if (has('nvim'))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has('termguicolors'))
    set termguicolors
  endif
endif
let g:onedark_hide_endofbuffer=1
let g:onedark_termcolors=16
colorscheme onedark

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indentation
set autoindent
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
aug vimrc_tabs
  au!
  au FileType go set tabstop=4 softtabstop=4 shiftwidth=4
  au FileType snippets set expandtab
aug END

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

" Motions
nmap j gj
nmap k gk

" Shifts
nnoremap < v<<esc>
      \ :echo 'Dedent'<cr>
nnoremap > v><esc>
      \ :echo 'Indent'<cr>

" Selections
nnoremap <leader>a ggVG
vnoremap <leader>a <esc>ggVG

nnoremap <backspace> <nop>
nnoremap <space> <nop>
nnoremap <cr> <nop>

" Jumps
nmap <silent> [a <Plug>(ale_previous_wrap)
nmap <silent> ]a <Plug>(ale_next_wrap)
nnoremap <leader>% :MtaJumpToOtherTag<cr>

" Buffers
nnoremap <leader>w :w<cr>
nnoremap <leader>W :wa<cr>
nnoremap <silent> <leader>q :BD<cr>
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
nnoremap <leader>] :bn<cr>
nnoremap <leader>[ :bp<cr>

" Windows
nnoremap <leader><right> :vs<cr>
nnoremap <leader><down> :sp<cr>
nnoremap <leader><left> :set splitright&<cr>:vs<cr>:set splitright<cr>
nnoremap <leader><up> :set splitbelow&<cr>:sp<cr>:set splitbelow<cr>
nnoremap <c-w>> :vertical resize +15<cr>
nnoremap <c-w>< :vertical resize -15<cr>
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
" https://stackoverflow.com/a/31502538
aug vimrc_switch_windows
  au!
  au VimEnter * unmap <C-j>
  au VimEnter * noremap <C-j> <C-w>j
aug END

" Tabs
nnoremap <leader>> :tabn<cr>
nnoremap <leader>< :tabp<cr>

" Clipboard
nnoremap <leader>Y "*Y
      \ :echo 'Copy to system clipboard'<cr>
vnoremap <leader>y "*y
      \ :echo 'Copy to system clipboard'<cr>
nnoremap <leader>p "*p
      \ :echo 'Paste from system clipboard'<cr>
vnoremap <leader>p "*p
      \ :echo 'Paste from system clipboard'<cr>

" Snippets
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'
nnoremap <leader>u :edit ~/.vim/ultisnips/

" Files
nnoremap <silent> <leader>r :e<cr>
nnoremap <leader>v :edit ~/.vimrc<cr>
nnoremap <silent> <leader>V :source ~/.vimrc<cr>
      \ :echo 'Source configuration'<cr>

" Searching
nnoremap <silent> <leader>/ :noh<cr>
      \ :echo 'Remove search highlighting'<cr>
nmap     <C-F>f <Plug>CtrlSFPrompt
nmap     <C-F>w <Plug>CtrlSFCwordPath
nmap     <C-F>n <Plug>CtrlSFPwordPath
nnoremap <C-F>t :CtrlSFToggle<cr>
inoremap <C-F>t <Esc>:CtrlSFToggle<cr>

" Whitespace
nnoremap <leader>t /\s\+$<cr>
      \ :echo 'Search trailing whitespace'<cr>
nnoremap <leader>T :%s/\s\+$//e<cr>:let @/=""<cr>
      \ :echo 'Trim trailing whitespace'<cr>

" Syntax
nnoremap <silent> <leader>x :if exists('g:syntax_on') <Bar>
      \     syntax off <Bar>
      \ else <Bar>
      \     syntax enable <Bar>
      \ endif <cr>
      \ :echo 'Toggle syntax'<cr>

" HTML
let g:user_emmet_leader_key='<C-e>'

" Markdown
nnoremap <silent> <leader>m :LivedownToggle<cr>
      \ :echo 'Toggle livedown'<cr>

" Column
nnoremap <silent> <leader>c :execute 'setlocal colorcolumn='
      \ . (&colorcolumn == '' ? '80' : '')<cr>
      \ :echo 'Toggle column 80'<cr>

" Spelling
nnoremap <silent> <leader>s :setlocal spell!<cr>
      \ :echo 'Toggle spell check'<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Markdown
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_no_default_key_mappings=1

" Lightline
set laststatus=2
set noshowmode
let g:lightline={}
let g:lightline.colorscheme='onedark'
let g:lightline.component_function={
      \ 'gitbranch': 'MyGitbranch',
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
      \            [ 'relativepath', 'readonly', 'modified' ],
      \            [ 'gitbranch' ] ],
      \ 'right': [
      \            [ 'linter_checking', 'lineinfo' ],
      \            [ 'linter_warnings', 'linter_errors', 'percent' ],
      \            [ 'filetype' ] ]
      \ }
let g:lightline#ale#indicator_checking="\uf110 "
let g:lightline#ale#indicator_warnings="\uf071 "
let g:lightline#ale#indicator_errors="\uf05e "
function! MyGitbranch()
  let branch = fugitive#head()
  return strlen(branch) != 0 ?
        \ "\uf418 " . fugitive#head() : ''
endfunction
function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ?
        \ &filetype . ' ' . WebDevIconsGetFileTypeSymbol() . ' ' : 'no ft') : ''
endfunction
function! MyFileformat()
  return winwidth(0) > 70 ?
        \ (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol() . ' ') : ''
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
  au FileType html,jinja,gohtmltmpl,css,scss,coffee,javascript EmmetInstall
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
let g:ale_sign_error='•'
let g:ale_sign_warning='•'
let g:ale_lint_delay=5000
let g:ale_linters={
      \ 'javascript': ['eslint'],
      \ 'python': ['flake8']
      \ }
let g:ale_javascript_eslint_executable='npx eslint'

" Local vimrc
let g:localvimrc_persistent=1

" Gutentags
let g:gutentags_ctags_tagfile='.tags'

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

" Python
let g:python_highlight_operators=0
let g:python_highlight_indent_errors=0
let g:python_highlight_space_errors=0
let g:python_highlight_doctests=0
let g:python_highlight_all=1
let g:python_highlight_file_headers_as_comments=1

" Livedown
let g:livedown_open=1
let g:livedown_browser='firefox'

" Dirvish
let g:dirvish_mode = ':sort ,^.*[\/],'

" MatchTagAlways
let g:mta_filetypes = {
      \ 'html' : 1,
      \ 'xhtml' : 1,
      \ 'xml' : 1,
      \ 'jinja' : 1,
      \ 'gohtmltmpl': 1,
      \ }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Highlights
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ALE
highlight link ALEWarningSign WarningMsg

" Signature
highlight link SignatureMarkText Todo

" Buftabline
highlight link BufTabLineCurrent LightlineLeft_normal_1
highlight link BufTabLineActive LightlineRight_normal_2
highlight link BufTabLineHidden LightlineRight_normal_2

" Matching tags
highlight! link MatchParen ToolbarLine
