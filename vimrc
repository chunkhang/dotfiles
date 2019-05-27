" vim: set foldmethod=marker nomodeline:

" =============================================================================
" VIM-PLUG {{{
" =============================================================================

call plug#begin('~/.vim/plugged')

" -----------------------------------------------------------------------------
" Appearance
" -----------------------------------------------------------------------------
Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'kshenoy/vim-signature'
Plug 'ap/vim-buftabline'
Plug 'ryanoasis/vim-devicons'
if has('mac')
  Plug 'sjl/vitality.vim'
endif
if v:version >= 801
  Plug 'markonm/traces.vim'
endif
Plug 'machakann/vim-highlightedyank'
if !exists('##TextYankPost')
  map y <Plug>(highlightedyank)
endif

" -----------------------------------------------------------------------------
" Utility
" -----------------------------------------------------------------------------
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
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
if has('python') || has('python3')
  Plug 'SirVer/ultisnips'
endif

" -----------------------------------------------------------------------------
" Git
" -----------------------------------------------------------------------------
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'rhysd/conflict-marker.vim'

" -----------------------------------------------------------------------------
" Language
" -----------------------------------------------------------------------------
Plug 'neoclide/vim-jsx-improve'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'kchmck/vim-coffee-script'
Plug 'hail2u/vim-css3-syntax'
Plug 'cakebaker/scss-syntax.vim'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'derekwyatt/vim-scala'
Plug 'gre/play2vim'
Plug 'posva/vim-vue'
Plug 'lepture/vim-jinja'
Plug 'plasticboy/vim-markdown'
Plug 'PProvost/vim-markdown-jekyll'
Plug 'vim-latex/vim-latex'

" -----------------------------------------------------------------------------
" Linting
" -----------------------------------------------------------------------------
Plug 'w0rp/ale'

" -----------------------------------------------------------------------------
" Writing
" -----------------------------------------------------------------------------
Plug 'vimwiki/vimwiki'
if has('mac')
  Plug 'itchyny/dictionary.vim'
endif
if has('python') || has('python3')
  Plug 'Ron89/thesaurus_query.vim'
endif

" -----------------------------------------------------------------------------
" Debugging
" -----------------------------------------------------------------------------
Plug 'dahu/bisectly'

call plug#end()

" }}}
" =============================================================================
" BASIC {{{
" =============================================================================

let mapleader = ' '

" Required by vimwiki
set nocompatible

set encoding=utf-8
scriptencoding utf-8

set history=1000
set hidden
set nobackup
set noswapfile
set autoread
set lazyredraw
set timeoutlen=1000
set ttimeoutlen=0
set spelllang=en_gb
set modelines=2
set foldlevelstart=99
set number
set relativenumber
set scrolloff=10
set wildmenu
set showcmd
set ruler
set cursorline
set ignorecase
set smartcase
set hlsearch
set incsearch
set showmatch
set belloff=all
set mouse=a
set splitbelow
set splitright
set shortmess+=IT
set autoindent
set breakindent
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set list
set listchars=tab:\|\ ,trail:.,extends:#,nbsp:.
set backspace=indent,eol,start
set laststatus=2
set noshowmode
set updatetime=250
set signcolumn=yes
set synmaxcol=200
set regexpengine=1
if executable('par')
  set formatprg=par
endif

" Fallback to bash syntax
" https://redd.it/4xb0fg
let g:is_bash = 1

augroup vimrc
  autocmd!
augroup END

" }}}
" =============================================================================
" FUNCTIONS {{{
" =============================================================================

" Delete all empty buffers
" https://redd.it/1a4yf1
function! s:clear_empty_buffers()
  let buffers = filter(
        \ range(1, bufnr('$')),
        \ 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val) < 0 &&
        \ (getbufline(v:val, 1, "$") == [""])'
        \ )
  if !empty(buffers)
    execute 'bd '.join(buffers, ' ')
  endif
endfunction

" Set buffer into writing mode
" https://www.drbunsen.org/writing-in-vim/
function! s:enter_writing_mode()
  setlocal formatoptions+=1
  setlocal noexpandtab
  setlocal spell
  setlocal complete+=k
  setlocal textwidth=79
  setlocal wrap
  setlocal linebreak
  call SuperTabSetDefaultCompletionType('<c-n>')
endfunction

" Highlight group using onedark.vim colors
function! s:highlight_onedark(group, color)
  let l:colors = onedark#GetColors()
  execute 'highlight ' . a:group . ' guifg=' . l:colors[a:color].gui
endfunction

" Print highlight groups under cursor
" https://stackoverflow.com/a/9464929
function! s:print_highlight_groups()
  if !exists('*synstack')
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction

" Create gist on ix.io with link copied to system clipboard
" http://aboumrad.info/faster-pastes-with-ix-io.html
function! s:create_gist(line1, line2)
  let l:range = ':' . a:line1 . ',' . a:line2
  silent! execute 'normal! ' . l:range . "write !ix | pbcopy\<cr>"
endfunction

" Toggle column to show where folds are
function! s:toggle_fold_column()
  if empty(&foldcolumn)
    setlocal foldcolumn=1
  else
    setlocal foldcolumn=0
  endif
endfunction

" Toggle spell checking
function! s:toggle_spell_check()
  setlocal spell!
endfunction

" Toggle syntax highlighting
function! s:toggle_syntax()
  if exists('g:syntax_on')
    syntax off
  else
    syntax enable
  endif
endfunction

" Toggle column to show where col 80 ruler is
function! s:toggle_ruler()
  if empty(&colorcolumn)
    setlocal colorcolumn=80
  else
    setlocal colorcolumn=
  endif
endfunction

" Reveal trailing whitespace
" https://stackoverflow.com/a/47746577
function! s:reveal_trails()
  let @/ = '\s\+$'
  call feedkeys("/\<cr>")
endfunction

" Trim trailing whitespace
function! s:trim_trails()
  let @/ = '\s\+$'
  silent! execute "normal! :%s///e\<cr>"
endfunction

" Split window into given direction
function! s:split_window(direction)
  if a:direction ==# 'left'
    setlocal nosplitright
    vsplit
  endif
  if a:direction ==# 'right'
    setlocal splitright
    vsplit
  endif
  if a:direction ==# 'up'
    setlocal nosplitbelow
    split
  endif
  if a:direction ==# 'down'
    setlocal splitbelow
    split
  endif
endfunction

" Delete all lowercase and uppercase marks
function! s:clear_marks()
  delmarks!
  delmarks A-Z
  wviminfo!
endfunction

" }}}
" =============================================================================
" COMMANDS {{{
" =============================================================================

command! Fold call <sid>toggle_fold_column()
command! -range=% Gist call <sid>create_gist(<line1>, <line2>)
command! Ruler call <sid>toggle_ruler()
command! Spelling call <sid>toggle_spell_check()
command! Write call <sid>enter_writing_mode()

" }}}
" =============================================================================
" MAPPINGS {{{
" =============================================================================

" -----------------------------------------------------------------------------
" Disable keys
" -----------------------------------------------------------------------------
nnoremap <backspace> <nop>
nnoremap <space> <nop>
nnoremap <cr> <nop>

" -----------------------------------------------------------------------------
" Moving
" -----------------------------------------------------------------------------
" Page down and up
nnoremap <C-m> <C-d>
nnoremap <C-n> <C-u>
" Visual line down and up
nnoremap j gj
nnoremap k gk
" Move between words in line
inoremap <C-j> <C-o>b
inoremap <C-k> <C-o>w
inoremap <C-h> <C-o>_
inoremap <C-l> <C-o>A

" -----------------------------------------------------------------------------
" Editing
" -----------------------------------------------------------------------------
" Select all lines
nnoremap <leader>a ggVG
" Insert new line
nnoremap <leader>o o<esc>
nnoremap <leader>O O<esc>
" Copy to system clipboard
nnoremap <leader>y "*yy
vnoremap <leader>y "*y
" Cut to system clipboard
nnoremap <leader>d "*dd
vnoremap <leader>d "*d
" Paste from system clipboard
nnoremap <leader>p "*p
vnoremap <leader>p "*p

" -----------------------------------------------------------------------------
" Jumping
" -----------------------------------------------------------------------------
" Buffers
nnoremap <silent> <leader>] :bnext<cr>
nnoremap <silent> <leader>[ :bprev<cr>
" Linting errors
nmap [a <Plug>(ale_previous_wrap)
nmap ]a <Plug>(ale_next_wrap)
" Tabs
nnoremap <silent> ]t :tabnext<cr>
nnoremap <silent> [t :tabprev<cr>
" Folds
nnoremap ]z zj
nnoremap [z zk
" Quickfix list
nnoremap <silent> ]q :cnext<cr>
nnoremap <silent> [q :cprev<cr>
" Location list
nnoremap <silent> ]l :lnext<cr>
nnoremap <silent> [l :lprev<cr>

" -----------------------------------------------------------------------------
" Buffers
" -----------------------------------------------------------------------------
" Write buffer
nnoremap <silent> <leader>w :update<cr>
nnoremap <silent> <leader>W :wall<cr>
" Refresh buffer
nnoremap <silent> <leader>r :e<cr>
" Close buffer
nnoremap <silent> <leader>q :BD<cr>
" Go to buffer
nmap <leader>1 <Plug>BufTabLine.Go(1)
nmap <leader>2 <Plug>BufTabLine.Go(2)
nmap <leader>3 <Plug>BufTabLine.Go(3)
nmap <leader>4 <Plug>BufTabLine.Go(4)
nmap <leader>5 <Plug>BufTabLine.Go(5)
nmap <leader>6 <Plug>BufTabLine.Go(6)
nmap <leader>7 <Plug>BufTabLine.Go(7)
nmap <leader>8 <Plug>BufTabLine.Go(8)
nmap <leader>9 <Plug>BufTabLine.Go(9)

" -----------------------------------------------------------------------------
" Windows
" -----------------------------------------------------------------------------
" Split window
nnoremap <silent> <leader><left> :call <sid>split_window('left')<cr>
nnoremap <silent> <leader><right> :call <sid>split_window('right')<cr>
nnoremap <silent> <leader><down> :call <sid>split_window('down')<cr>
nnoremap <silent> <leader><up> :call <sid>split_window('up')<cr>
" Move around windows
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l
augroup vimrc
  " Map this way because of vim-latex
  " https://stackoverflow.com/a/31502538
  autocmd VimEnter * unmap <C-j>
  autocmd VimEnter * nnoremap <C-j> <C-w>j
augroup END

" -----------------------------------------------------------------------------
" Miscellaneous
" -----------------------------------------------------------------------------
" Manage vimrc
nnoremap <silent> <leader>v :edit ~/.vimrc<cr>
nnoremap <leader>V :source ~/.vimrc<cr>
" Manage syntax
nnoremap <silent> <leader>s :call <sid>toggle_syntax()<cr>
nnoremap <silent> <leader>S :call <sid>print_highlight_groups()<cr>
" Manage trailing whitespace
nnoremap <silent> <leader>t :call<sid>reveal_trails()<cr>
nnoremap <silent> <leader>T :call <sid>trim_trails()<cr>
" Clear search pattern highlight
nnoremap <silent> <leader>/ :nohlsearch<cr>
" Clear all marks
nnoremap <silent> <leader>m :call <sid>clear_marks()<cr>
" Open shell
nnoremap <silent> <leader>z :shell<cr>
" Force last command
nnoremap ! :<up>!

" -----------------------------------------------------------------------------
" ctrlsf.vim
" -----------------------------------------------------------------------------
nmap <C-f>f <Plug>CtrlSFPrompt
nmap <C-f>w <Plug>CtrlSFCwordPath
nnoremap <C-f>t :CtrlSFToggle<cr>

" -----------------------------------------------------------------------------
" ultisnips
" -----------------------------------------------------------------------------
nnoremap <silent> <leader>u :edit ~/.vim/ultisnips<cr>

" -----------------------------------------------------------------------------
" dictionary.vim
" -----------------------------------------------------------------------------
nmap <C-d>d :Dictionary<space>
nmap <C-d>w :Dictionary -cursor-word<cr>

" -----------------------------------------------------------------------------
" thesaurus_query.vim
" -----------------------------------------------------------------------------
nmap <C-e>e :Thesaurus<space>
nmap <C-e>w :ThesaurusQueryLookupCurrentWord<cr>

" }}}
" =============================================================================
" PLUGINS {{{
" =============================================================================

" -----------------------------------------------------------------------------
" onedark.vim
" https://github.com/joshdick/onedark.vim#installation
" -----------------------------------------------------------------------------
if has('termguicolors')
  set termguicolors
endif
let g:onedark_hide_endofbuffer = 1
let g:onedark_termcolors = 16
colorscheme onedark

" -----------------------------------------------------------------------------
" lightline.vim
" https://github.com/ryanoasis/vim-devicons/wiki/usage#lightline-setup
" https://nerdfonts.com/
" -----------------------------------------------------------------------------
function! MyLightlineGitBranch()
  let branch = fugitive#head()
  if empty(branch)
    return ''
  endif
  return "\uf418 " . fugitive#head()
endfunction
function! MyLightlineFileType()
  return winwidth(0) > 70 ? (strlen(&filetype) ?
        \ &filetype . ' ' . WebDevIconsGetFileTypeSymbol() . ' ' : 'no ft') : ''
endfunction
function! MyLightlineSpell()
  if empty(&spell)
    return ''
  endif
  return 'spell ' . "\uf9c5"
endfunction
let g:lightline = {}
let g:lightline.colorscheme = 'onedark'
let g:lightline.component_function = {
      \ 'gitbranch': 'MyLightlineGitBranch',
      \ 'filetype': 'MyLightlineFileType',
      \ 'spell': 'MyLightlineSpell',
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
      \            [ 'gitbranch' ] ],
      \ 'right': [ [ 'linter_checking', 'lineinfo' ],
      \            [ 'linter_warnings', 'linter_errors', 'percent' ],
      \            [ 'spell', 'filetype' ] ]
      \ }
let g:lightline#ale#indicator_checking = "\uf110 "
let g:lightline#ale#indicator_warnings = "\uf071 "
let g:lightline#ale#indicator_errors = "\uf05e "

" -----------------------------------------------------------------------------
" vim-signature
" -----------------------------------------------------------------------------
call <sid>highlight_onedark('SignatureMarkText', 'purple')

" -----------------------------------------------------------------------------
" vim-buftabline
" -----------------------------------------------------------------------------
let g:buftabline_show = 1
let g:buftabline_numbers = 2
let g:buftabline_indicators = 1
highlight! link BufTabLineCurrent LightlineLeft_normal_1
highlight! link BufTabLineActive LightlineRight_normal_2
highlight! link BufTabLineHidden LightlineRight_normal_2

" -----------------------------------------------------------------------------
" auto-pairs
" -----------------------------------------------------------------------------
let g:AutoPairsMapCh = 0

" -----------------------------------------------------------------------------
" ctrlp.vim
" -----------------------------------------------------------------------------
let g:ctrlp_root_markers = ['.ctrlp']
let g:ctrlp_use_caching = 0
if executable('rg')
  let g:ctrlp_user_command = 'rg %s --files --color=never'
endif

" -----------------------------------------------------------------------------
" ctrlsf.vim
" -----------------------------------------------------------------------------
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
let g:ctrlsf_populate_qflist = 1
if executable('rg')
  let g:ctrlsf_ackprg = 'rg'
endif

" -----------------------------------------------------------------------------
" vim-bufkill
" -----------------------------------------------------------------------------
let g:BufKillCreateMappings = 0

" -----------------------------------------------------------------------------
" emmet-vim
" -----------------------------------------------------------------------------
let g:user_emmet_leader_key = '<C-e>'
let g:user_emmet_install_global = 0
augroup vimrc
  autocmd FileType html,jinja,gohtmltmpl,xml EmmetInstall
  autocmd FileType css,scss EmmetInstall
  autocmd FileType javascript,coffee EmmetInstall
augroup END

" -----------------------------------------------------------------------------
" vim-gutentags
" -----------------------------------------------------------------------------
let g:gutentags_ctags_tagfile = '.tags'

" -----------------------------------------------------------------------------
" vim-dirvish
" -----------------------------------------------------------------------------
let g:dirvish_mode = ':sort | sort ,^.*[^/]$, r'
let g:dirvish_relative_paths = 1

" -----------------------------------------------------------------------------
" vim-livedown
" -----------------------------------------------------------------------------
let g:livedown_autorun = 0
let g:livedown_open = 1
let g:livedown_browser = 'firefox'
let g:livedown_port = 1337

" -----------------------------------------------------------------------------
" vim-localvimrc
" -----------------------------------------------------------------------------
let g:localvimrc_persistent = 1

" -----------------------------------------------------------------------------
" vim-commentary
" -----------------------------------------------------------------------------
augroup vimrc
  autocmd FileType jinja setlocal commentstring={#\ %s\ #}
  autocmd FileType vue,sbt setlocal commentstring=\/\/\ %s
  autocmd FileType hocon setlocal commentstring=#\ %s
augroup END

" -----------------------------------------------------------------------------
" ultisnips
" -----------------------------------------------------------------------------
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsEditSplit = 'context'
" Fix ultisnips lag issue
" https://github.com/SirVer/ultisnips/issues/593#issuecomment-361338769
augroup vimrc
  autocmd VimEnter * autocmd! UltiSnips_AutoTrigger
augroup END

" -----------------------------------------------------------------------------
" vim-signify
" -----------------------------------------------------------------------------
let g:signify_vcs_list = ['git']
let g:signify_sign_change = '~'
let g:signify_sign_delete = '-'
let g:signify_sign_show_count = 0

" -----------------------------------------------------------------------------
" vim-go
" -----------------------------------------------------------------------------
let g:go_fmt_fail_silently = 1

" -----------------------------------------------------------------------------
" vim-markdown
" -----------------------------------------------------------------------------
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_no_default_key_mappings = 1

" -----------------------------------------------------------------------------
" vim-jsx-improve
" -----------------------------------------------------------------------------
let g:javascript_plugin_flow = 1

" -----------------------------------------------------------------------------
" ale
" -----------------------------------------------------------------------------
let g:ale_sign_error = '•'
let g:ale_sign_warning = '•'
let g:ale_lint_delay = 5000
let g:ale_linters = {
      \ 'javascript': ['eslint'],
      \ 'vim': ['vint'],
      \ }
" https://pnpm.js.org/docs/en/pnpx-cli.html
let g:ale_javascript_eslint_executable = 'pnpx eslint'
call <sid>highlight_onedark('ALEWarningSign', 'dark_yellow')

" -----------------------------------------------------------------------------
" vimwiki
" -----------------------------------------------------------------------------
let g:vimwiki_map_prefix = '<leader><leader>'
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
call <sid>highlight_onedark('VimWikiHeader1', 'red')
call <sid>highlight_onedark('VimWikiHeader2', 'green')
call <sid>highlight_onedark('VimWikiHeader3', 'blue')
call <sid>highlight_onedark('VimwikiTag', 'purple')
function! s:reindex_diary()
  VimwikiDiaryGenerateLinks
  update
endfunction
augroup vimrc
  autocmd BufEnter */diary/index.wiki call <sid>reindex_diary()
  autocmd BufEnter */diary/????-??-??.wiki call <sid>enter_writing_mode()
  autocmd BufWritePre */diary/????-??-??.wiki normal! gggqG}
  " Non-conflicting key to invoke vim-dirvish
  autocmd FileType vimwiki nnoremap \ :Dirvish<cr>
augroup END

" -----------------------------------------------------------------------------
" thesaurus_query.vim
" -----------------------------------------------------------------------------
let g:tq_enabled_backends = ['openoffice_en', 'mthesaur_txt']
let g:tq_openoffice_en_file = '~/.vim/thesaurus/th_en_US_new'
let g:tq_mthesaur_file = '~/.vim/thesaurus/mthesaur.txt'
let g:tq_map_keys = 0
let g:tq_use_vim_autocompletefunc = 0

" -----------------------------------------------------------------------------
" matchparen
" -----------------------------------------------------------------------------
highlight! link MatchParen ToolbarLine

" }}}
" =============================================================================
" AUTOCOMMANDS {{{
" =============================================================================

augroup vimrc

  " Clear empty buffers when jumping to global marks
  autocmd BufWinEnter * call <sid>clear_empty_buffers()

  " Disable auto comment
  let s:autocomment_exceptions = ['markdown', 'yaml']
  autocmd FileType * if index(s:autocomment_exceptions, &filetype) < 0
        \| setlocal formatoptions-=cro

  " Indentation
  autocmd FileType zsh,go setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd FileType snippets setlocal expandtab

augroup END

" }}}
" =============================================================================
