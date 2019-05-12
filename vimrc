" vim: set foldmethod=marker nomodeline :

" =============================================================================
" VIM-PLUG {{{
" =============================================================================

call plug#begin('~/.vim/plugged')

" Appearance
Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'kshenoy/vim-signature'
Plug 'ap/vim-buftabline'
Plug 'ryanoasis/vim-devicons'
if has('mac')
  Plug 'sjl/vitality.vim'
endif
if has('python') || has('python3')
  Plug 'Valloric/MatchTagAlways'
endif
if v:version >= 801
  Plug 'markonm/traces.vim'
endif
Plug 'machakann/vim-highlightedyank'
if !exists('##TextYankPost')
  map y <Plug>(highlightedyank)
endif

" Utility
Plug 'jiangmiao/auto-pairs'
Plug 'ervandew/supertab'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'dyng/ctrlsf.vim'
Plug 'henrik/vim-indexed-search'
Plug 'qpkorr/vim-bufkill'
Plug 'danro/rename.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'adelarsq/vim-matchit'
Plug 'mattn/emmet-vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'justinmk/vim-dirvish'
Plug 'shime/vim-livedown'
Plug 'embear/vim-localvimrc'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
if has('python') || has('python3')
  Plug 'SirVer/ultisnips'
endif

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'rhysd/conflict-marker.vim'

" Language
Plug 'neoclide/vim-jsx-improve'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'kchmck/vim-coffee-script'
Plug 'hail2u/vim-css3-syntax'
Plug 'cakebaker/scss-syntax.vim'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'derekwyatt/vim-scala'
Plug 'gre/play2vim'
Plug 'posva/vim-vue'
Plug 'lepture/vim-jinja'
Plug 'plasticboy/vim-markdown'
Plug 'PProvost/vim-markdown-jekyll'
Plug 'vim-latex/vim-latex'

" Linting
Plug 'w0rp/ale'

" Writing
Plug 'vimwiki/vimwiki'
if has('mac')
  Plug 'itchyny/dictionary.vim'
endif
if has('python') || has('python3')
  Plug 'Ron89/thesaurus_query.vim'
endif

call plug#end()

" }}}
" =============================================================================
" GENERAL {{{
" =============================================================================

" Compatibility
set nocompatible

" Lines of history
set history=1000

" Buffers
set hidden
augroup vimrc_remove_empty_buffer
  autocmd!
  autocmd BufWinEnter * call MyCleanEmptyBuffers()
augroup END
" https://redd.it/1a4yf1
function! MyCleanEmptyBuffers()
  let buffers = filter(
        \ range(1, bufnr('$')),
        \ 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val) < 0 &&
        \ (getbufline(v:val, 1, "$") == [""])'
        \ )
  if !empty(buffers)
    execute 'bd '.join(buffers, ' ')
  endif
endfunction

" Disable backup and swap
set nobackup
set noswapfile

" Autoread
set autoread

" Escape to normal mode faster
set timeoutlen=1000
set ttimeoutlen=0

" Remove auto comment
augroup vimrc_remove_auto_comment
  autocmd!
  autocmd FileType * setlocal formatoptions-=cro
  " Exceptions
  autocmd FileType markdown setlocal formatoptions+=cro
augroup END

" Spelling language
set spelllang=en_gb

" Shell
set shell=/usr/local/bin/zsh

" Mode line
set modelines=2

" Fold
set foldlevelstart=99

" }}}
" =============================================================================
" USER INTERFACE {{{
" =============================================================================

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

" }}}
" =============================================================================
" COLORS AND FONTS {{{
" =============================================================================

" Syntax highlighting
let g:is_bash = 1

" Encoding
set encoding=utf-8
scriptencoding utf-8

" Color scheme
if empty($TMUX)
  if has('nvim')
    let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
  endif
  if has('termguicolors')
    set termguicolors
  endif
endif
let g:onedark_hide_endofbuffer = 1
let g:onedark_termcolors = 16
colorscheme onedark

" }}}
" =============================================================================
" TEXT {{{
" =============================================================================

" Indentation
set autoindent
set breakindent
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
augroup vimrc_tabs
  autocmd!
  autocmd FileType zsh,go setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd FileType snippets setlocal expandtab
augroup END

" Highlight whitespaces
set list
set listchars=tab:\|\ ,trail:.,extends:#,nbsp:.

" Backspace
set backspace=indent,eol,start

" Formatting
set formatprg=par

" Writing mode
function! MyWritingMode()
  setlocal formatoptions+=1
  setlocal noexpandtab
  setlocal spell
  setlocal complete+=k
  setlocal textwidth=79
  setlocal wrap
  setlocal linebreak
  call SuperTabSetDefaultCompletionType("<c-n>")
endfunction
function! MyFormatWriting()
  normal gggqG}
endfunction
augroup vimrc_writing
  autocmd!
  autocmd BufEnter */diary/????-??-??.wiki call MyWritingMode()
  autocmd BufWritePre */diary/????-??-??.wiki call MyFormatWriting()
augroup END
command! Write call MyWritingMode()

" }}}
" =============================================================================
" MAPPINGS {{{
" =============================================================================

" Leader key
let mapleader = ' '

" Motions
nmap j gj
nmap k gk

" Selections
nnoremap <leader>a ggVG
vnoremap <leader>a <esc>ggVG

nnoremap <backspace> <nop>
nnoremap <space> <nop>
nnoremap <cr> <nop>

" Jumps
nmap <silent> [a <Plug>(ale_previous_wrap)
nmap <silent> ]a <Plug>(ale_next_wrap)

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
nnoremap <leader><left> :setlocal splitright&<cr>:vs<cr>:setlocal splitright<cr>
nnoremap <leader><up> :setlocal splitbelow&<cr>:sp<cr>:setlocal splitbelow<cr>
nnoremap <c-w>> :vertical resize +15<cr>
nnoremap <c-w>< :vertical resize -15<cr>
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
" https://stackoverflow.com/a/31502538
augroup vimrc_switch_windows
  autocmd!
  autocmd VimEnter * unmap <C-j>
  autocmd VimEnter * noremap <C-j> <C-w>j
augroup END

" Tabs
nnoremap <leader>> :tabn<cr>
nnoremap <leader>< :tabp<cr>

" Clipboard
nnoremap <leader>y "*yy
      \ :echo 'Copy to system clipboard'<cr>
vnoremap <leader>y "*y
      \ :echo 'Copy to system clipboard'<cr>
nnoremap <leader>d "*dd
      \ :echo 'Cut to system clipboard'<cr>
vnoremap <leader>d "*d
      \ :echo 'Cut to system clipboard'<cr>
nnoremap <leader>p "*p
      \ :echo 'Paste from system clipboard'<cr>
vnoremap <leader>p "*p
      \ :echo 'Paste from system clipboard'<cr>

" Snippets
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
nnoremap <leader>u :edit ~/.vim/ultisnips/

" Files
nnoremap <silent> <leader>r :e<cr>
nnoremap <leader>v :edit ~/.vimrc<cr>
nnoremap <silent> <leader>V :source ~/.vimrc<cr>
      \ :echo 'Source configuration'<cr>

" Sessions
nnoremap <leader>o :Obsess<cr>
nnoremap <leader>O :Obsess!<cr>

" Searching
nnoremap <silent> <leader>/ :noh<cr>
nmap <C-f>f <Plug>CtrlSFPrompt
nmap <C-f>w <Plug>CtrlSFCwordPath
nnoremap <C-f>t :CtrlSFToggle<cr>

" Whitespace
nnoremap <leader>t /\s\+$<cr>
      \ :echo 'Search trailing whitespace'<cr>
nnoremap <leader>T :%s/\s\+$//e<cr>:let @/ = ""<cr>
      \ :echo 'Trim trailing whitespace'<cr>

" Syntax
nnoremap <silent> <leader>x :if exists('g:syntax_on') <Bar>
      \     syntax off <Bar>
      \ else <Bar>
      \     syntax enable <Bar>
      \ endif <cr>
      \ :echo 'Toggle syntax'<cr>
function! MySynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction
nnoremap <leader>X :call MySynStack()<cr>

" HTML
let g:user_emmet_leader_key = '<C-e>'

" Markdown
nnoremap <silent> <leader>m :LivedownToggle<cr>
      \ :echo 'Toggle livedown'<cr>

" Folding
nnoremap <silent> <leader>f :execute 'setlocal foldcolumn='
      \ . (&foldcolumn == '' ? '1' : '0')<cr>
      \ :echo 'Toggle fold column'<cr>

" Column
nnoremap <silent> <leader>c :execute 'setlocal colorcolumn='
      \ . (&colorcolumn == '' ? '80' : '')<cr>
      \ :echo 'Toggle column 80'<cr>

" Spelling
nnoremap <silent> <leader>s :setlocal spell!<cr>
      \ :echo 'Toggle spell check'<cr>

" Thesaurus
nmap <C-e>e :Thesaurus<space>
nmap <C-e>w :ThesaurusQueryLookupCurrentWord<cr>

" Dictionary
nmap <C-d>d :Dictionary<space>
nmap <C-d>w :Dictionary -cursor-word

" Commands
nnoremap ! :<up>!

" Shell
nnoremap <silent> <leader>z :sh<cr>

" Gist
noremap <silent> <leader>i :w !ix <Bar> pbcopy<cr>
      \ :echo 'Copy gist link to system clipboard'<cr>

" Vimwiki
let g:vimwiki_map_prefix = '<leader><leader>'

" Dirvish
" Add another key for invoking dirvish because vimwiki uses - as well
nnoremap <silent> \ :Dirvish<cr>

" }}}
" =============================================================================
" PLUGINS {{{
" =============================================================================

" Markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_no_default_key_mappings = 1

" Lightline
set laststatus=2
set noshowmode
let g:lightline = {}
let g:lightline.colorscheme = 'onedark'
let g:lightline.component_function = {
      \ 'gitbranch': 'MyGitbranch',
      \ 'filetype': 'MyFiletype',
      \ 'fileformat': 'MyFileformat',
      \ 'session': 'MySession'
      \ }
let g:lightline.component_expand = {
      \ 'linter_checking': 'lightline#ale#checking',
      \ 'linter_warnings': 'lightline#ale#warnings',
      \ 'linter_errors': 'lightline#ale#errors'
      \ }
let g:lightline.component_type = {
      \ 'linter_checking': 'left',
      \ 'linter_warnings': 'warning',
      \ 'linter_errors': 'error'
      \ }
let g:lightline.active = {
      \ 'left' : [ [ 'mode', 'paste' ],
      \            [ 'relativepath', 'readonly', 'modified' ],
      \            [ 'gitbranch', 'session' ] ],
      \ 'right': [
      \            [ 'linter_checking', 'lineinfo' ],
      \            [ 'linter_warnings', 'linter_errors', 'percent' ],
      \            [ 'filetype' ] ]
      \ }
let g:lightline#ale#indicator_checking = "\uf110 "
let g:lightline#ale#indicator_warnings = "\uf071 "
let g:lightline#ale#indicator_errors = "\uf05e "
function! MyGitbranch()
  let branch = fugitive#head()
  return !empty(branch) ?
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
function! MySession()
  let session = ObsessionStatus('active', 'paused')
  if !empty(session)
    return session ==# 'active' ?
      \ "\uf662" : "\uf663"
  endif
  return ''
endfunction

" Git gutter
set updatetime=250
set signcolumn=yes
let g:gitgutter_max_signs = 1000

" Ctrlp
let g:ctrlp_root_markers = ['.ctrlp']
let g:ctrlp_use_caching = 0
let g:ctrlp_user_command = 'rg %s --files --color=never'

" Emmet
let g:user_emmet_install_global = 0
augroup vimrc_emmet
  autocmd!
  autocmd FileType html,jinja,gohtmltmpl,css,scss,coffee,javascript,xml EmmetInstall
augroup END

" Commentary
augroup vimrc_commentary
  autocmd!
  autocmd FileType jinja setlocal commentstring={#\ %s\ #}
  autocmd FileType vue,sbt setlocal commentstring=\/\/\ %s
  autocmd FileType hocon setlocal commentstring=#\ %s
augroup END

" CtrlSF
let g:ctrlsf_case_sensitive = 'yes'
let g:ctrlsf_default_root = 'project'
let g:ctrlsf_extra_root_markers = ['.ctrlsf']
let g:ctrlsf_position = 'right'
let g:ctrlsf_auto_close = {
      \ 'normal': 0,
      \ 'compact': 0
      \ }
let g:ctrlsf_indent = 2
let g:ctrlsf_regex_pattern = 1
let g:ctrlsf_ackprg = 'rg'

" ALE
let g:ale_sign_error = '•'
let g:ale_sign_warning = '•'
let g:ale_lint_delay = 5000
let g:ale_linters = {
      \ 'javascript': ['eslint'],
      \ 'python': ['flake8']
      \ }
let g:ale_javascript_eslint_executable = 'pnpx eslint'

" Local vimrc
let g:localvimrc_persistent = 1

" Gutentags
let g:gutentags_ctags_tagfile = '.tags'

" Go
let g:go_fmt_fail_silently = 1

" Bufkill
let g:BufKillCreateMappings = 0

" Ultisnips
let g:UltiSnipsEditSplit = 'context'
" https://github.com/SirVer/ultisnips/issues/593#issuecomment-361338769
augroup vimrc_ultisnips
  autocmd!
  autocmd VimEnter * autocmd! UltiSnips_AutoTrigger
augroup END

" Buftabline
let g:buftabline_show = 1
let g:buftabline_numbers = 2
let g:buftabline_indicators = 1

" Python
let g:python_highlight_operators = 0
let g:python_highlight_indent_errors = 0
let g:python_highlight_space_errors = 0
let g:python_highlight_doctests = 0
let g:python_highlight_all = 1
let g:python_highlight_file_headers_as_comments = 1

" Livedown
let g:livedown_autorun = 0
let g:livedown_open = 1
let g:livedown_browser = 'firefox'
let g:livedown_port = 1337

" Dirvish
let g:dirvish_mode = ':sort | sort ,^.*[^/]$, r'
let g:dirvish_relative_paths = 1

" MatchTagAlways
let g:mta_filetypes = {
      \ 'html' : 1,
      \ 'xhtml' : 1,
      \ 'xml' : 1,
      \ 'jinja' : 1,
      \ 'gohtmltmpl': 1,
      \ }

" Thesaurus
let g:tq_enabled_backends = ['openoffice_en', 'mthesaur_txt']
let g:tq_openoffice_en_file = '~/.vim/thesaurus/th_en_US_new'
let g:tq_mthesaur_file = '~/.vim/thesaurus/mthesaur.txt'
let g:tq_map_keys = 0
let g:tq_use_vim_autocompletefunc = 0

" JavaScript
let g:javascript_plugin_flow = 1

" VimWiki
let g:vimwiki_list = [{
      \ 'path': '~/Dropbox/wiki/',
      \ 'path_html': '~/Dropbox/wiki-html',
      \ 'auto_toc': 1,
      \ 'diary_index': 'index',
      \ 'auto_diary_index': 1,
      \ 'auto_tags': 1,
      \ }]
let g:vimwiki_auto_chdir = 1
let g:vimwiki_dir_link = 'index'
let g:vimwiki_hl_headers = 1
let g:vimwiki_folding = 'custom'
let g:vimwiki_table_mappings = 0

" }}}
" =============================================================================
" HIGHLIGHTS {{{
" =============================================================================

" Helper function for highlighting based on onedark colors
let s:colors = onedark#GetColors()
function! MyHighlight(group, color)
  execute 'highlight ' . a:group . ' guifg=' . s:colors[a:color].gui
endfunction

" ALE
call MyHighlight('ALEWarningSign', 'dark_yellow')

" Signature
call MyHighlight('SignatureMarkText', 'purple')

" Buftabline
highlight link BufTabLineCurrent LightlineLeft_normal_1
highlight link BufTabLineActive LightlineRight_normal_2
highlight link BufTabLineHidden LightlineRight_normal_2

" Matching tags
highlight! link MatchParen ToolbarLine

" Vimwiki
call MyHighlight('VimWikiHeader1', 'red')
call MyHighlight('VimWikiHeader2', 'green')
call MyHighlight('VimWikiHeader3', 'blue')
call MyHighlight('VimwikiTag', 'purple')

" }}}
" =============================================================================
