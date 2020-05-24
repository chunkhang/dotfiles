" vim: set foldmethod=marker nomodeline:

" Executable dependencies:
" - par: http://www.nicemice.net/par/
" - rg: https://github.com/BurntSushi/ripgrep

" =============================================================================
" VIM-PLUG {{{
" =============================================================================

call plug#begin('~/.vim/plugged')

" Conditional activation for plugins
" https://github.com/junegunn/vim-plug/wiki/tips#conditional-activation
" https://github.com/junegunn/vim-plug/issues/640#issuecomment-307007055
function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

" -----------------------------------------------------------------------------
" Appearance
" -----------------------------------------------------------------------------
Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'kshenoy/vim-signature'
Plug 'bagrat/vim-buffet'
Plug 'ryanoasis/vim-devicons'
Plug 'sjl/vitality.vim', Cond(has('mac') && !has('nvim'))
Plug 'markonm/traces.vim', Cond(has('nvim-0.2.3') \|\| v:version >= 801)
Plug 'camspiers/lens.vim'
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
Plug 'AndrewRadev/splitjoin.vim'
Plug 'AndrewRadev/switch.vim'
Plug 'machakann/vim-swap'
Plug 'adelarsq/vim-matchit'
Plug 'wellle/targets.vim'
Plug 'jceb/emmet.snippets'
Plug 'chrisbra/Colorizer'
" Plug 'ludovicchabant/vim-gutentags'
Plug '~/Workspace/vimscript/vim-gutentags'
Plug 'justinmk/vim-dirvish'
Plug 'embear/vim-localvimrc'
Plug 'qpkorr/vim-bufkill'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-eunuch'
Plug 'SirVer/ultisnips', Cond(has('python') \|\| has('python3'))

" -----------------------------------------------------------------------------
" Git
" -----------------------------------------------------------------------------
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'mhinz/vim-signify'
Plug 'rhysd/conflict-marker.vim'
Plug 'rhysd/git-messenger.vim'

" -----------------------------------------------------------------------------
" Language
" -----------------------------------------------------------------------------
Plug 'neoclide/vim-jsx-improve'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'jxnblk/vim-mdx-js'
Plug 'jparise/vim-graphql'
Plug 'kchmck/vim-coffee-script'
Plug 'hail2u/vim-css3-syntax'
Plug 'cakebaker/scss-syntax.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'derekwyatt/vim-scala'
Plug 'gre/play2vim'
Plug 'posva/vim-vue'
Plug 'lepture/vim-jinja'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'PProvost/vim-markdown-jekyll'
Plug 'vim-latex/vim-latex'
Plug 'chunkhang/vim-mbsync'
Plug 'chunkhang/msmtp.vim'
Plug 'neomutt/neomutt.vim'
Plug 'hashivim/vim-terraform'
Plug 'cespare/vim-toml'
Plug 'vito-c/jq.vim'

" -----------------------------------------------------------------------------
" Linting
" -----------------------------------------------------------------------------
Plug 'w0rp/ale'

" -----------------------------------------------------------------------------
" Writing
" -----------------------------------------------------------------------------
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'Konfekt/vim-mailquery'
Plug 'vimwiki/vimwiki'
Plug 'itchyny/dictionary.vim', Cond(has('mac'))
Plug 'Ron89/thesaurus_query.vim', Cond(has('python') \|\| has('python3'))

call plug#end()

" }}}
" =============================================================================
" BASIC {{{
" =============================================================================

let mapleader = ' '

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
set spelllang=en_gb,ms
set modelines=2
set foldlevelstart=99
set number
set relativenumber
set scrolloff=10
set sidescroll=1
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
set softtabstop=2
set shiftwidth=2
set list
set listchars=tab:\|\ ,trail:.,extends:#,nbsp:.
set backspace=indent,eol,start
set laststatus=2
set noshowmode
set updatetime=250
set signcolumn=yes
set synmaxcol=1000
set regexpengine=1
set shellcmdflag=-l\ -c
set maxmempattern=5000
set complete-=t
set iskeyword+=-
set formatprg=par
set grepprg=rg\ --vimgrep

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
  let l:buffers = filter(
        \ range(1, bufnr('$')),
        \ 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val) < 0 &&
        \ (getbufline(v:val, 1, "$") == [""])'
        \ )
  if !empty(buffers)
    execute 'bd '.join(buffers, ' ')
  endif
endfunction

" Highlight group using onedark.vim colors
let s:colors = onedark#GetColors()
function! s:highlight_onedark(group, color)
  execute 'highlight ' . a:group . ' guifg=' . s:colors[a:color].gui
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
  silent! execute '!pbpaste | xargs open'
endfunction

" Preview markdown on browser
function! s:preview_markdown(line1, line2)
  let l:range = ':' . a:line1 . ',' . a:line2
  silent! execute 'normal! ' . l:range . "write !~/.scripts/pandoc/browser\<cr>"
endfunction

" Toggle column to show where folds are
function! s:toggle_fold_column(bang)
  if a:bang
    setlocal foldcolumn=0
  else
    setlocal foldcolumn=1
  endif
endfunction

" Toggle spell checking
function! s:toggle_spell_check(bang)
  if a:bang
    setlocal nospell
  else
    setlocal spell
  endif
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
function! s:toggle_ruler(bang)
  if a:bang
    setlocal colorcolumn=
  else
    setlocal colorcolumn=80
  endif
endfunction

" Reveal or trim trailing whitespace
" https://stackoverflow.com/a/47746577
function! s:handle_trailing_whitespace(bang)
  if a:bang
    let @/ = '\s\+$'
    silent! execute "normal! :%s///e\<cr>"
  else
    let @/ = '\s\+$'
    call feedkeys("/\<cr>")
  endif
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

command! -bang Fold call <sid>toggle_fold_column(<bang>0)
command! -range=% Gist call <sid>create_gist(<line1>, <line2>)
command! -range=% Preview call <sid>preview_markdown(<line1>, <line2>)
command! -bang Ruler call <sid>toggle_ruler(<bang>0)
command! -bang Spell call <sid>toggle_spell_check(<bang>0)
command! -bang Trail call <sid>handle_trailing_whitespace(<bang>0)

" }}}
" =============================================================================
" MAPPINGS {{{
" =============================================================================

" -----------------------------------------------------------------------------
" Disable keys
" -----------------------------------------------------------------------------
nnoremap <backspace> <nop>
nnoremap <space> <nop>

" -----------------------------------------------------------------------------
" Moving
" -----------------------------------------------------------------------------
" Page down and up
nnoremap <C-up> 5<C-y>
nnoremap <C-down> 5<C-e>
" Visual line down and up
nnoremap j gj
nnoremap k gk
" Move between words in line
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
" Append comma
nnoremap <leader>, A,<esc>
vnoremap <silent> <leader>, :normal A,<cr>
" Complete line
inoremap <C-space> <C-x><C-l>

" -----------------------------------------------------------------------------
" Jumping
" -----------------------------------------------------------------------------
" Cursor
nnoremap <silent> <S-tab> <C-o>
" Buffers
nnoremap <silent> <leader>\ :edit#<cr>
nnoremap <silent> <leader>] :bnext<cr>
nnoremap <silent> <leader>[ :bprev<cr>
nmap <leader>1 <Plug>BuffetSwitch(1)
nmap <leader>2 <Plug>BuffetSwitch(2)
nmap <leader>3 <Plug>BuffetSwitch(3)
nmap <leader>4 <Plug>BuffetSwitch(4)
nmap <leader>5 <Plug>BuffetSwitch(5)
nmap <leader>6 <Plug>BuffetSwitch(6)
nmap <leader>7 <Plug>BuffetSwitch(7)
nmap <leader>8 <Plug>BuffetSwitch(8)
nmap <leader>9 <Plug>BuffetSwitch(9)
nmap <leader>0 <Plug>BuffetSwitch(10)
" Linting errors and warnings
nmap [e <Plug>(ale_previous_wrap_error)
nmap ]e <Plug>(ale_next_wrap_error)
nmap [w <Plug>(ale_previous_wrap_warning)
nmap ]w <Plug>(ale_next_wrap_warning)
" Tabs
nnoremap <silent> ]t :tabnext<cr>
nnoremap <silent> [t :tabprev<cr>
" Folds
nnoremap ]z zj
nnoremap [z zk
" Quickfix list
nnoremap <silent> ]q :cnext<cr>
nnoremap <silent> [q :cprev<cr>
nnoremap <silent> ]f :cnfile<cr>
nnoremap <silent> [f :cpfile<cr>
" Location list
nnoremap <silent> ]l :lnext<cr>
nnoremap <silent> [l :lprev<cr>

" -----------------------------------------------------------------------------
" Buffers
" -----------------------------------------------------------------------------
" Write buffer
nnoremap <silent> <leader>w :write<cr>
nnoremap <silent> <leader>W :wall<cr>
" Refresh buffer
nnoremap <silent> <leader>r :e<cr>
" Close buffer
nnoremap <silent> <leader>q :BD<cr>
nnoremap <silent> <leader>Q :bufdo bd<cr>

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
if has('nvim')
  tnoremap <C-k> <C-\><C-n><C-w>k
  tnoremap <C-h> <C-\><C-n><C-w>h
  tnoremap <C-l> <C-\><C-n><C-w>l
endif
augroup vimrc
  " Map this way because of vim-latex
  " https://stackoverflow.com/a/31502538
  autocmd VimEnter * unmap <C-j>
  autocmd VimEnter * nnoremap <C-j> <C-w>j
  if has('nvim')
    autocmd VimEnter * tnoremap <C-j> <C-\><C-n><C-w>j
  endif
augroup END

" -----------------------------------------------------------------------------
" Miscellaneous
" -----------------------------------------------------------------------------
" Manage vimrc
nnoremap <silent> <leader>v :edit ~/.vimrc<cr>
nnoremap <leader>V :source ~/.vimrc<cr>
" Manage syntax
nnoremap <silent> <leader>s :call <sid>print_highlight_groups()<cr>
nnoremap <silent> <leader>S :call <sid>toggle_syntax()<cr>
" Clear search pattern highlight
nnoremap <silent> <leader>/ :nohlsearch<cr>
" Clear all marks
nnoremap <silent> <leader>m :call <sid>clear_marks()<cr>
" Open shell
if has('nvim')
  nnoremap <silent> <leader>z :terminal<cr>
  tnoremap <esc> <C-\><C-n>
else
  nnoremap <silent> <leader>z :shell<cr>
endif

" -----------------------------------------------------------------------------
" ctrlsf.vim
" -----------------------------------------------------------------------------
nmap <C-f>f <Plug>CtrlSFPrompt
nmap <C-f>w <Plug>CtrlSFCwordPath
nnoremap <C-f>t :CtrlSFToggle<cr>

" -----------------------------------------------------------------------------
" emmet.snippets
" -----------------------------------------------------------------------------
imap <C-e> <esc>daWae<tab><esc>pa<tab>

" -----------------------------------------------------------------------------
" Colorizer
" -----------------------------------------------------------------------------
nnoremap <leader>c :ColorToggle<cr>
nnoremap <leader>C :ColorContrast<cr>

" -----------------------------------------------------------------------------
" ultisnips
" -----------------------------------------------------------------------------
nnoremap <silent> <leader>u :edit ~/.vim/ultisnips<cr>

" -----------------------------------------------------------------------------
" git-messenger
" -----------------------------------------------------------------------------
nmap <leader>b <Plug>(git-messenger)

" -----------------------------------------------------------------------------
" tabular
" -----------------------------------------------------------------------------
nnoremap <leader>t :Tabularize
nnoremap <leader>t<space> :Tabularize spaces<cr>
vnoremap <leader>t<space> :Tabularize spaces<cr>
nnoremap <leader>t= :Tabularize assignment<cr>
vnoremap <leader>t= :Tabularize assignment<cr>
nnoremap <leader>t: :Tabularize /:<cr>
vnoremap <leader>t: :Tabularize /:<cr>

" -----------------------------------------------------------------------------
" goyo.vim
" -----------------------------------------------------------------------------
nnoremap <leader>g :Goyo<cr>

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
" :help xterm-true-color
" -----------------------------------------------------------------------------
if has('termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
let g:onedark_hide_endofbuffer = 1
let g:onedark_termcolors = 16
colorscheme onedark

" -----------------------------------------------------------------------------
" lightline.vim
" https://github.com/ryanoasis/vim-devicons/wiki/usage#lightline-setup
" https://nerdfonts.com/
" https://github.com/bagrat/vim-buffet/issues/20
" -----------------------------------------------------------------------------
function! MyLightlineDirectory()
  return "\ufc6e " . fnamemodify(getcwd(), ':t')
endfunction
function! MyLightlineGitBranch()
  let l:branch = fugitive#head()
  if empty(branch)
    return ''
  endif
  return "\uf418 " . l:branch
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
      \ 'cwd': 'MyLightlineDirectory',
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
      \            [ 'cwd', 'gitbranch' ] ],
      \ 'right': [ [ 'linter_checking', 'lineinfo' ],
      \            [ 'linter_warnings', 'linter_errors', 'percent' ],
      \            [ 'spell', 'filetype' ] ]
      \ }
let g:lightline.enable = { 'tabline': 0 }
let g:lightline#ale#indicator_checking = "\uf110 "
let g:lightline#ale#indicator_warnings = "\uf071 "
let g:lightline#ale#indicator_errors = "\uf05e "

" -----------------------------------------------------------------------------
" vim-signature
" -----------------------------------------------------------------------------
call <sid>highlight_onedark('SignatureMarkText', 'purple')

" -----------------------------------------------------------------------------
" vim-buffet
" -----------------------------------------------------------------------------
let g:buffet_always_show_tabline = 0
let g:buffet_separator = ''
let g:buffet_tab_icon = "\uf0ca "
let g:buffet_show_index = 1
let g:buffet_left_trunc_icon = "\uf0d9"
let g:buffet_right_trunc_icon = "\uf0da "
function! g:BuffetSetCustomColors()
  highlight! link BuffetCurrentBuffer LightlineLeft_normal_1
  highlight! link BuffetActiveBuffer LightlineRight_normal_2
  highlight! link BuffetBuffer LightlineRight_normal_2
  highlight! link BuffetTrunc LightlineRight_normal_2
  highlight! link BuffetTab LightlineLeft_normal_0
endfunction

" -----------------------------------------------------------------------------
" auto-pairs
" -----------------------------------------------------------------------------
let g:AutoPairsMapCh = 0

" -----------------------------------------------------------------------------
" ctrlp.vim
" -----------------------------------------------------------------------------
let g:ctrlp_root_markers = ['.ctrlp']
let g:ctrlp_use_caching = 1
let g:ctrlp_prompt_mappings = {
      \ 'PrtHistory(1)': [],
      \ 'PrtClearCache()': ['<c-p>'],
      \ }
let g:ctrlp_open_multiple_files = 'i'
let g:ctrlp_user_command = 'rg %s --files --color=never'

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
let g:ctrlsf_ackprg = 'rg'

" -----------------------------------------------------------------------------
" splitjoin.vim
" -----------------------------------------------------------------------------
let g:splitjoin_trailing_comma = 1

" -----------------------------------------------------------------------------
" switch.vim
" -----------------------------------------------------------------------------
let g:switch_mapping = '\'
let g:switch_reverse_mapping = '\|'
let g:switch_find_smallest_match = 0
let g:switch_custom_definitions = [
      \ [ '===', '!==' ],
      \ [ '==', '!=' ],
      \ [ '<=', '>=' ],
      \ [ '<', '>' ],
      \ [ '+', '-' ],
      \ [ '0', '1' ],
      \ [ 'off', 'on' ],
      \ ]

" -----------------------------------------------------------------------------
" Colorizer
" -----------------------------------------------------------------------------
let g:colorizer_fgcontrast = 0
let g:colorizer_colornames = 0

" -----------------------------------------------------------------------------
" vim-gutentags
" -----------------------------------------------------------------------------
let g:gutentags_ctags_tagfile = '.tags'
let g:gutentags_file_list_command = 'rg --files --color=never'

" -----------------------------------------------------------------------------
" vim-dirvish
" -----------------------------------------------------------------------------
let g:dirvish_mode = ':sort | sort ,^.*[^/]$, r'
let g:dirvish_relative_paths = 1

" -----------------------------------------------------------------------------
" vim-localvimrc
" -----------------------------------------------------------------------------
let g:localvimrc_persistent = 1

" -----------------------------------------------------------------------------
" vim-bufkill
" -----------------------------------------------------------------------------
let g:BufKillCreateMappings = 0

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
call <sid>highlight_onedark('snipLeadingSpaces', 'black')

" -----------------------------------------------------------------------------
" vim-signify
" -----------------------------------------------------------------------------
let g:signify_vcs_list = ['git']
let g:signify_sign_change = '~'
let g:signify_sign_delete = '-'
let g:signify_sign_show_count = 0

" -----------------------------------------------------------------------------
" git-messenger.vim
" -----------------------------------------------------------------------------
let g:git_messenger_no_default_mappings = v:true
let g:git_messenger_always_into_popup = v:true
highlight! link gitmessengerPopupNormal CursorLine
highlight! link gitmessengerHeader Statement
highlight! link gitmessengerHash Special
highlight! link gitmessengerHistory Title
function! s:setup_git_messenger_popup()
    nmap <buffer><tab> o
    nmap <buffer><S-tab> O
endfunction
augroup vimrc
  autocmd FileType gitmessengerpopup call <SID>setup_git_messenger_popup()
augroup END

" -----------------------------------------------------------------------------
" vim-go
" -----------------------------------------------------------------------------
let g:go_fmt_fail_silently = 1
let g:go_def_mode = 'godef'
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_extra_types = 1

" -----------------------------------------------------------------------------
" vim-jsx-improve
" -----------------------------------------------------------------------------
let g:javascript_plugin_flow = 1

" -----------------------------------------------------------------------------
" vim-jsx-typescript
" -----------------------------------------------------------------------------
call <sid>highlight_onedark('typescriptParens', 'white')
call <sid>highlight_onedark('typescriptStorageClass', 'purple')
call <sid>highlight_onedark('typescriptInterpolationDelimiter', 'red')
call <sid>highlight_onedark('typescriptNull', 'dark_yellow')
call <sid>highlight_onedark('typescriptType', 'dark_yellow')
call <sid>highlight_onedark('typescriptGlobalObjects', 'yellow')
call <sid>highlight_onedark('typescriptDeprecated', 'blue')
call <sid>highlight_onedark('typescriptBranch', 'red')
call <sid>highlight_onedark('typescriptLogicSymbols', 'purple')
call <sid>highlight_onedark('ReactLifeCycleMethods', 'blue')
call <sid>highlight_onedark('ReduxKeywords', 'white')
call <sid>highlight_onedark('tsxCloseTag', 'white')

" -----------------------------------------------------------------------------
" vim-markdown
" -----------------------------------------------------------------------------
call <sid>highlight_onedark('htmlH1', 'red')
call <sid>highlight_onedark('htmlH2', 'green')
call <sid>highlight_onedark('htmlH3', 'blue')
call <sid>highlight_onedark('htmlH4', 'purple')
call <sid>highlight_onedark('htmlH5', 'purple')
call <sid>highlight_onedark('htmlH6', 'purple')

" -----------------------------------------------------------------------------
" vim-terraform
" -----------------------------------------------------------------------------
let g:terraform_fmt_on_save = 1

" -----------------------------------------------------------------------------
" vim-mailquery
" -----------------------------------------------------------------------------
let g:mailquery_folder = $HOME . '/Mail'

" -----------------------------------------------------------------------------
" vim-toml
" -----------------------------------------------------------------------------
call <sid>highlight_onedark('tomlTable', 'blue')

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
call <sid>highlight_onedark('ALEWarningSign', 'dark_yellow')

" -----------------------------------------------------------------------------
" goyo.vim
" https://github.com/junegunn/goyo.vim/wiki/Customization
" https://www.drbunsen.org/writing-in-vim/
" -----------------------------------------------------------------------------
let g:goyo_linenr = 1
function! s:goyo_enter()
  set showtabline=0
  set scrolloff=999
  set nocursorline
  set formatoptions+=1awt
  set noexpandtab
  set spell
  set complete+=k
  set textwidth=72
  set linebreak
  call SuperTabSetDefaultCompletionType('<c-n>')
  let b:quitting = 0
  let b:quitting_bang = 0
  augroup vimrc
    autocmd QuitPre <buffer> let b:quitting = 1
    autocmd BufAdd,TabEnter * set showtabline=0
  augroup END
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
  Limelight
endfunction
function! s:goyo_leave()
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif
  Limelight!
endfunction
augroup vimrc
  autocmd! User GoyoEnter call <SID>goyo_enter()
  autocmd! User GoyoLeave call <SID>goyo_leave()
augroup END

" -----------------------------------------------------------------------------
" limelight.vim
" -----------------------------------------------------------------------------
let g:limelight_priority = -1

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
  autocmd BufWritePre */diary/????-??-??.wiki normal! gggqG}zz
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
let g:tq_use_vim_autocomplete = 0

" -----------------------------------------------------------------------------
" matchparen
" -----------------------------------------------------------------------------
highlight! link MatchParen Visual

" }}}
" =============================================================================
" AUTOCOMMANDS {{{
" =============================================================================

augroup vimrc

  " Set or overrule filetypes
  autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx
  autocmd BufNewFile,BufRead .zprofile,zprofile set filetype=zsh
  autocmd BufNewFile,BufRead .muttrc,muttrc set filetype=neomuttrc
  autocmd BufNewFile,BufRead .tags set filetype=tags
  autocmd BufNewFile,BufRead Podfile set filetype=conf
  autocmd BufNewFile,BufRead *.mdx set filetype=javascript.mdx
  autocmd BufNewFile,BufRead gitconfig set filetype=toml

  " Disable automatic comment insertion
  autocmd FileType * set formatoptions-=cro

  " Easier to quit certain windows
  autocmd FileType help,qf,godoc noremap <silent> <buffer> q :q<cr>
  if has('nvim')
    autocmd TermOpen * noremap <silent> <buffer> q :q<cr>
  endif

  " Clear empty buffers when jumping to global marks
  autocmd BufWinEnter * call <sid>clear_empty_buffers()

  " Indentation
  autocmd FileType go set softtabstop=0 tabstop=4 shiftwidth=4
  autocmd FileType snippets set expandtab
  autocmd FileType javascript.mdx set shiftwidth=2
  autocmd BufNewFile,BufRead Info.plist set noexpandtab shiftwidth=0
  autocmd FileType groovy set shiftwidth=4

  " Folding
  autocmd Filetype yaml set foldmethod=indent

  " Format JSON
  autocmd FileType json setlocal equalprg=jq

  " Compose email
  autocmd Filetype mail set textwidth=72

  " Disable cursor line for diff mode
  autocmd BufEnter * if &diff | set nocursorline | endif

  " Documentation
  autocmd FileType javascript set keywordprg=~/.scripts/docs/duckduckgo

  " Start insert mode automatically in terminal
  if has('nvim')
    autocmd TermOpen * startinsert
    autocmd BufEnter term://* startinsert
  endif

augroup END

" }}}
" =============================================================================
