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
Plug 'chrisbra/Colorizer'
Plug 'ludovicchabant/vim-gutentags'
Plug 'justinmk/vim-dirvish'
Plug 'embear/vim-localvimrc'
Plug 'qpkorr/vim-bufkill'
Plug 'SirVer/ultisnips', Cond(has('python') \|\| has('python3'))
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-projectionist'
Plug 'dhruvasagar/vim-zoom'
Plug 'tommcdo/vim-lion'

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
Plug 'chemzqm/vim-jsx-improve'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'jxnblk/vim-mdx-js'
Plug 'jparise/vim-graphql'
Plug 'kchmck/vim-coffee-script'
Plug 'hail2u/vim-css3-syntax'
Plug 'cakebaker/scss-syntax.vim'
Plug 'vim-python/python-syntax'
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
Plug 'Joorem/vim-haproxy'
Plug 'vim-scripts/icalendar.vim'

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
Plug 'lyokha/vim-xkbswitch'

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
set tabstop=2
set shiftwidth=2
set shiftround
set list
set listchars=tab:\|\ ,trail:.,extends:#,nbsp:.
set backspace=indent,eol,start
set laststatus=2
set noshowmode
set updatetime=500
set signcolumn=yes
set synmaxcol=1000
set regexpengine=1
set shellcmdflag=-l\ -c
set maxmempattern=5000
set complete-=t
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

" Open repository for Vim plug
function! s:gx_vim()
  let l:line = getline('.')
  let l:repo = matchstr(line, "^Plug '\\zs.\\{-}\\ze'")
  if empty(l:repo)
    return
  endif
  let l:url = 'https://github.com/' . l:repo
  call netrw#BrowseX(l:url, 0)
endfunction

" Open repository for Go import
function! s:gx_go()
  let l:line = getline('.')
  let l:url = matchstr(line, '"\zs.*\ze"')
  if empty(l:url)
    return
  endif
  let l:url = 'https://' . l:url
  call netrw#BrowseX(l:url, 0)
endfunction

" Go to path for Go import
function! s:gf_go()
  let l:module_path = findfile('go.mod', '.;')
  if empty(l:module_path)
    return
  endif
  for l:line in readfile(l:module_path)
    let l:module = matchstr(l:line, '^module \zs.*\ze$')
    if !empty(l:module)
      let l:pat = '"' . l:module . '/\zs.*\ze"'
      let l:submodule = matchstr(getline('.'), l:pat)
      if empty(l:submodule)
        return
      endif
      let l:module_dir = fnamemodify(l:module_path, ':h')
      let l:path = l:module_dir . '/' . l:submodule
      execute 'edit' l:path
      return
    endif
  endfor
endfunction

" Go to path for JavaScript import
function! s:gf_javascript()
  " Line must contain `require` or `import`
  let l:line = getline('.')
  if empty(matchstr(l:line, '\(import\|from\|require\)'))
    return
  endif

  " Extract matched import path
  let l:match = matchstr(l:line, "'\\zs.*\\ze'")

  " Resolve import aliases
  let l:imports = [l:match]
  let l:aliases = {
        \ '\~': ['.'],
        \ }
  for alias in items(l:aliases)
    let l:alias_from = alias[0]
    for alias_to in alias[1]
      if empty(matchstr(l:match, l:alias_from))
        continue
      endif
      let l:import = substitute(l:match, l:alias_from, alias_to, '')
      let l:imports = add(l:imports, l:import)
    endfor
  endfor

  " Check all possible extensions
  " Return whether path with extension was opened successfully
  function! s:open_import(path)
    let l:exts = ['', '.js', '.jsx', '/index.js', '/index.jsx']
    for ext in exts
      let l:candidate = a:path . ext
      if filereadable(l:candidate)
        execute 'edit' l:candidate
        return v:true
      endif
    endfor
    return v:false
  endfunction

  for import in l:imports
    " Import is relative to current working directory
    if <sid>open_import(l:import)
      break
    endif
    " Import is relative to directory of current file
    let l:dir = expand('%:h')
    let l:rel = fnamemodify(l:dir . '/' . l:import, ':.')
    if <sid>open_import(l:rel)
      break
    endif
  endfor
endfunction

" Go to path for SCSS import
function! s:gf_scss()
  " Line must contain `@import`
  let l:line = getline('.')
  if empty(matchstr(l:line, '@import'))
    return
  endif

  " Extract matched import path
  let l:match = matchstr(l:line, "'\\zs.*\\ze'")

  " Resolve import aliases
  let l:imports = [l:match]
  let l:aliases = {
        \ '\~': ['.'],
        \ }
  for alias in items(l:aliases)
    let l:alias_from = alias[0]
    for alias_to in alias[1]
      if empty(matchstr(l:match, l:alias_from))
        continue
      endif
      let l:import = substitute(l:match, l:alias_from, alias_to, '')
      let l:imports = add(l:imports, l:import)
    endfor
  endfor

  " Check all possible extensions
  " Return whether path with extension was opened successfully
  function! s:open_import(path)
    let l:exts = ['']
    for ext in exts
      let l:candidate = a:path . ext
      if filereadable(l:candidate)
        execute 'edit' l:candidate
        return v:true
      endif
    endfor
    return v:false
  endfunction

  for import in l:imports
    " Import is relative to current working directory
    if <sid>open_import(l:import)
      break
    endif
    " Import is relative to directory of current file
    let l:dir = expand('%:h')
    let l:rel = fnamemodify(l:dir . '/' . l:import, ':.')
    if <sid>open_import(l:rel)
      break
    endif
  endfor
endfunction

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
command! -range=% Markdown call <sid>preview_markdown(<line1>, <line2>)
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
" Visual line down and up
nnoremap j gj
nnoremap k gk
" Move between words in line
inoremap <C-h> <C-o>_
inoremap <C-l> <C-o>A
" Move page down and up
nnoremap <silent> <C-down> <C-d>
nnoremap <silent> <C-up> <C-u>

" -----------------------------------------------------------------------------
" Editing
" -----------------------------------------------------------------------------
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
" Append dot
nnoremap <leader>. A.<esc>
vnoremap <silent> <leader>. :normal A.<cr>
" Append semicolon
nnoremap <leader>; A;<esc>
vnoremap <silent> <leader>; :normal A;<cr>
" Complete line
inoremap <C-space> <C-x><C-l>
" File text object
vmap <silent> af :<C-u>normal! ggVG<cr>
vmap <silent> if af
omap <silent> af :normal Vaf<cr>
omap <silent> if af
nmap <leader>a Vaf

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
" Make
nnoremap <silent> <leader><leader> :make<cr>
" Manage vimrc
nnoremap <silent> <leader>v :edit ~/.vimrc<cr>
" Manage syntax
nnoremap <silent> <leader>s :call <sid>print_highlight_groups()<cr>
nnoremap <silent> <leader>S :call <sid>toggle_syntax()<cr>
" Clear search pattern highlight
nnoremap <silent> <leader>/ :nohlsearch<cr>
" Clear all marks
nnoremap <silent> <leader>m :call <sid>clear_marks()<cr>
" Print file path
nnoremap <silent> <leader>f :echo expand('%p')<cr>
" Open file paths / urls
augroup vimrc
  autocmd FileType vim nnoremap <buffer> <silent> gx :call <sid>gx_vim()<cr>
  autocmd FileType go nnoremap <buffer> <silent> gx :call <sid>gx_go()<cr>
  autocmd FileType go nnoremap <buffer> <silent> gf :call <sid>gf_go()<cr>
  autocmd FileType javascript,javascript.jsx nnoremap <buffer> <silent> gf :call <sid>gf_javascript()<cr>
  autocmd FileType scss nnoremap <buffer> <silent> gf :call <sid>gf_scss()<cr>
augroup END

" -----------------------------------------------------------------------------
" ctrlp.vim
" -----------------------------------------------------------------------------
nnoremap <C-b> :CtrlPBuffer<cr>

" -----------------------------------------------------------------------------
" ctrlsf.vim
" -----------------------------------------------------------------------------
nmap <C-f>f <Plug>CtrlSFPrompt
nmap <C-f>w <Plug>CtrlSFCwordPath

" -----------------------------------------------------------------------------
" Colorizer
" -----------------------------------------------------------------------------
nnoremap <leader>c :ColorToggle<cr>

" -----------------------------------------------------------------------------
" vim-dirvish
" -----------------------------------------------------------------------------
augroup vimrc
  autocmd FileType dirvish silent! nmap <buffer> q <Plug>(dirvish_quit)
augroup END

" -----------------------------------------------------------------------------
" ultisnips
" -----------------------------------------------------------------------------
nnoremap <silent> <leader>u :edit ~/.vim/ultisnips<cr>

" -----------------------------------------------------------------------------
" vim-projectionist
" -----------------------------------------------------------------------------
nnoremap <silent> \| :A<cr>
nnoremap <silent> g\| :AV<cr>

" -----------------------------------------------------------------------------
" vim-zoom
" -----------------------------------------------------------------------------
nmap <leader>z <Plug>(zoom-toggle)

" -----------------------------------------------------------------------------
" vim-fugitive
" -----------------------------------------------------------------------------
nmap <silent> <leader>B :Gblame<cr>

" -----------------------------------------------------------------------------
" git-messenger
" -----------------------------------------------------------------------------
nmap <leader>b <Plug>(git-messenger)

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
let g:AutoPairsShortcutToggle = ''
let g:AutoPairsShortcutFastWrap = ''
let g:AutoPairsShortcutJump = ''
let g:AutoPairsShortcutBackInsert = ''
let g:AutoPairs = {
      \ '(': ')',
      \ '[': ']',
      \ '{': '}',
      \ "'": "'",
      \ '"': '"',
      \ '`': '`',
      \ '<!--': '-->',
      \ '{%': '%}',
      \ '{#': '#}',
      \ }

" -----------------------------------------------------------------------------
" ctrlp.vim
" -----------------------------------------------------------------------------
let g:ctrlp_root_markers = ['.root']
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
let g:ctrlsf_extra_root_markers = ['.root']
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
let g:switch_find_smallest_match = 0
let g:switch_custom_definitions = [
      \ [ '===', '!==' ],
      \ [ '==', '!=' ],
      \ [ '<=', '>=' ],
      \ [ '<', '>' ],
      \ [ '++', '--' ],
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
let g:localvimrc_ask = 0
let g:localvimrc_sandbox = 0

" -----------------------------------------------------------------------------
" vim-bufkill
" -----------------------------------------------------------------------------
let g:BufKillCreateMappings = 0

" -----------------------------------------------------------------------------
" vim-commentary
" -----------------------------------------------------------------------------
augroup vimrc
  autocmd FileType jinja,jinja.html setlocal commentstring={#\ %s\ #}
  autocmd FileType vue,sbt setlocal commentstring=\/\/\ %s
  autocmd FileType hocon setlocal commentstring=#\ %s
  autocmd FileType sql setlocal commentstring=--\ %s
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
let g:signify_skip = { 'vcs': { 'allow': ['git'] } }
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
  autocmd FileType gitmessengerpopup call <sid>setup_git_messenger_popup()
augroup END

" -----------------------------------------------------------------------------
" python-syntax
" -----------------------------------------------------------------------------
let g:python_highlight_all = 1

" -----------------------------------------------------------------------------
" vim-go
" -----------------------------------------------------------------------------
let g:go_def_mode = 'godef'
let g:go_fmt_fail_silently = 1
let g:go_gopls_enabled = 0
let g:go_metalinter_enabled = 0
let g:go_code_completion_enabled = 0
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
let g:javascript_plugin_jsdoc = 1
call <sid>highlight_onedark('jsDocTags', 'cyan')
call <sid>highlight_onedark('jsDocType', 'yellow')
call <sid>highlight_onedark('jsDocTypeNoParam', 'yellow')
call <sid>highlight_onedark('jsDocParam', 'white')

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
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_no_default_key_mappings = 1
call <sid>highlight_onedark('htmlH1', 'red')
call <sid>highlight_onedark('htmlH2', 'green')
call <sid>highlight_onedark('htmlH3', 'blue')
call <sid>highlight_onedark('htmlH4', 'purple')
call <sid>highlight_onedark('htmlH5', 'purple')
call <sid>highlight_onedark('htmlH6', 'purple')
augroup vimrc
  autocmd Syntax markdown syntax clear mkdLineBreak
augroup END

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
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_hover_cursor = 0
let g:ale_linters_explicit = 1
let g:ale_linters = {
      \ 'sh': ['shell'],
      \ 'zsh': ['shell'],
      \ 'vim': ['vint'],
      \ 'lua': ['luacheck'],
      \ 'javascript': ['eslint'],
      \ 'typescript': ['eslint'],
      \ 'go': ['gofmt', 'golint', 'go vet'],
      \ 'python': ['flake8', 'pyright'],
      \ 'css': ['stylelint'],
      \ 'scss': ['stylelint'],
      \ }
let g:ale_fixers = {
      \ 'yaml': ['prettier'],
      \ 'javascript': ['prettier'],
      \ 'css': ['prettier'],
      \ 'scss': ['prettier'],
      \ 'python': ['black'],
      \ }
let g:ale_fix_on_save = 1
let g:ale_python_pyright_config = {
      \ 'pyright': {
      \   'disableLanguageServices': v:true,
      \ },
      \}
let g:ale_python_black_change_directory = 0
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
  autocmd! User GoyoEnter call <sid>goyo_enter()
  autocmd! User GoyoLeave call <sid>goyo_leave()
augroup END

" -----------------------------------------------------------------------------
" limelight.vim
" -----------------------------------------------------------------------------
let g:limelight_priority = -1

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
  autocmd BufNewFile,BufRead *.js,*.jsx set filetype=javascript.jsx
  autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx
  autocmd BufNewFile,BufRead .zprofile,zprofile,.zlocal set filetype=zsh
  autocmd BufNewFile,BufRead .muttrc,muttrc set filetype=neomuttrc
  autocmd BufNewFile,BufRead .tags set filetype=tags
  autocmd BufNewFile,BufRead Podfile,Appfile,Fastfile,Matchfile set filetype=ruby
  autocmd BufNewFile,BufRead *.mdx set filetype=javascript.mdx
  autocmd BufNewFile,BufRead gitconfig set filetype=toml
  autocmd BufNewFile,BufRead tsconfig.json set filetype=javascript
  autocmd BufNewFile,BufRead justfile set filetype=make
  autocmd BufNewFile,BufRead .luacheckrc set filetype=lua
  autocmd BufNewFile,BufRead *.conf set filetype=conf
  autocmd BufNewFile,BufRead supervisord.conf set filetype=dosini
  autocmd BufNewFile,BufRead .flake8 set filetype=toml
  autocmd BufNewFile,BufRead Pipfile set filetype=toml
  autocmd BufNewFile,BufRead .coveragerc set filetype=dosini
  autocmd BufNewFile,BufRead pytest.ini set filetype=toml
  autocmd BufNewFile,BufRead *.ics set filetype=icalendar

  " Disable automatic comment insertion on new line
  autocmd FileType * set formatoptions-=o

  " Easier to quit certain windows
  autocmd FileType help,qf,godoc noremap <silent> <buffer> q :q<cr>
  if has('nvim')
    autocmd TermOpen * noremap <silent> <buffer> q :q<cr>
  endif

  " Clear empty buffers when jumping to global marks
  autocmd BufWinEnter * call <sid>clear_empty_buffers()

  " Indentation
  autocmd FileType snippets set expandtab
  autocmd FileType javascript.mdx set shiftwidth=2
  autocmd BufNewFile,BufRead Info.plist set noexpandtab shiftwidth=0
  autocmd FileType groovy set shiftwidth=4
  autocmd FileType markdown set shiftwidth=2 tabstop=2

  " Folding
  autocmd Filetype yaml set foldmethod=indent

  " Format JSON
  autocmd FileType json setlocal formatprg=jq

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

  " Treat dash as part of keyword
  autocmd FileType scss setlocal iskeyword+=-

augroup END

" }}}
" =============================================================================
