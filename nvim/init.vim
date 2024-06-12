" =============================================================================
" SETTINGS
" =============================================================================

" Options
set breakindent
set complete-=t
set cursorline
set expandtab
set foldlevelstart=99
set foldopen-=search
set formatprg=par
set grepprg=rg\ --vimgrep
set ignorecase
set lazyredraw
set list
set listchars=tab:\|\ ,trail:.,nbsp:.
set mouse=a
set noshowmode
set noswapfile
set number
set scrolloff=10
set shiftround
set shiftwidth=2
set shortmess+=I
set showmatch
set signcolumn=yes
set smartcase
set splitbelow
set splitright
set tabstop=2
set termguicolors
set updatetime=500

" Leader
let g:mapleader = ' '

" Providers
if has('mac')
  let $PATH = 
        \ '/opt/homebrew/opt/node@16/bin:' .
        \ '/opt/homebrew/opt/python@3.10/Frameworks/Python.framework/Versions/3.10/bin:' .
        \ $PATH
  let g:node_host_prog = '/opt/homebrew/bin/neovim-node-host'
  let g:python3_host_prog = '/opt/homebrew/opt/python@3.10/bin/python3.10'
else
  " TODO: Do not load this block in 42 computer
  let $PATH =
        \ $HOME . '/.nvm/versions/node/v16.20.2/bin:' .
        \ $HOME . '/.pyenv/versions/3.10.0/bin:' .
        \ $PATH
  let g:node_host_prog = $HOME . '/.nvm/versions/node/v16.20.2/bin/neovim-node-host'
  let g:python3_host_prog = $HOME . '/.pyenv/versions/3.10.0/bin/python3'
endif
let g:loaded_python_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_perl_provider = 0

if !has('mac')
  let g:clipboard = {
        \ 'name': 'xclip',
        \ 'copy': {
        \    '+': 'xclip -selection clipboard',
        \    '*': 'xclip -selection clipboard',
        \  },
        \ 'paste': {
        \    '+': 'xclip -selection clipboard -out',
        \    '*': 'xclip -selection clipboard -out',
        \ },
        \ 'cache_enabled': 1,
        \ }
  let g:netrw_browsex_viewer = 'gio open'
endif

let g:c_syntax_for_h = 1
let g:c_no_curly_error = 1

augroup init_settings
  autocmd!
  " Enable highlight on yank
  autocmd TextYankPost * silent! lua vim.highlight.on_yank {timeout=500}
augroup END

" =============================================================================
" PLUGINS
" =============================================================================

" Helper to set respective highlights in plugin configs
let g:plugin_highlights = {}

call plug#begin(stdpath('config') . '/plugged')

Plug '42Paris/42header', { 'for': 'c' } | runtime config/42header.vim
Plug 'AndrewRadev/splitjoin.vim' | runtime config/splitjoin.vim
Plug 'AndrewRadev/switch.vim' | runtime config/switch.vim
Plug 'Joorem/vim-haproxy'
Plug 'PProvost/vim-markdown-jekyll'
Plug 'SirVer/ultisnips' | runtime config/ultisnips.vim
Plug 'cakebaker/scss-syntax.vim'
Plug 'camspiers/lens.vim'
Plug 'cespare/vim-toml' | runtime config/toml.vim
Plug 'chemzqm/vim-jsx-improve' | runtime config/jsx_improve.vim
Plug 'chrisbra/Colorizer' | runtime config/colorizer.vim
Plug 'chunkhang/msmtp.vim'
Plug 'chunkhang/norminette-ale'
Plug 'chunkhang/supertab' | runtime config/supertab.vim
Plug 'chunkhang/vim-mbsync'
Plug 'digitaltoad/vim-pug'
Plug 'dyng/ctrlsf.vim' | runtime config/ctrlsf.vim
Plug 'embear/vim-localvimrc' | runtime config/localvimrc.vim
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' } | runtime config/go.vim
Plug 'godlygeek/tabular'
Plug 'hail2u/vim-css3-syntax'
Plug 'hashivim/vim-terraform' | runtime config/terraform.vim
Plug 'itchyny/lightline.vim' | runtime config/lightline.vim
Plug 'jiangmiao/auto-pairs' | runtime config/auto_pairs.vim
Plug 'joshdick/onedark.vim' | runtime config/onedark.vim
Plug 'jparise/vim-graphql'
Plug 'junegunn/vim-plug' | runtime config/plug.vim
Plug 'justinmk/vim-dirvish' | runtime config/dirvish.vim
Plug 'kshenoy/vim-signature' | runtime config/signature.vim
Plug 'leafgarland/typescript-vim'
Plug 'lepture/vim-jinja'
Plug 'liuchengxu/vim-clap', { 'tag': 'v0.37' } | runtime config/clap.vim
Plug 'ludovicchabant/vim-gutentags' | runtime config/gutentags.vim
Plug 'machakann/vim-swap'
Plug 'maximbaz/lightline-ale'
Plug 'mhinz/vim-signify' | runtime config/signify.vim
Plug 'neomutt/neomutt.vim'
Plug 'peitalin/vim-jsx-typescript' | runtime config/jsx_typescript.vim
Plug 'plasticboy/vim-markdown' | runtime config/markdown.vim
Plug 'rhysd/conflict-marker.vim'
Plug 'rhysd/git-messenger.vim' | runtime config/git_messenger.vim
Plug 'romgrk/barbar.nvim', { 'commit': '31ec83c' } | runtime config/barbar.vim
Plug 'tomlion/vim-solidity'
Plug 'tommcdo/vim-lion'
Plug 'towolf/vim-helm'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary' | runtime config/commentary.vim
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist' | runtime config/projectionist.vim
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'uarun/vim-protobuf'
Plug 'vim-python/python-syntax' | runtime config/python.vim
Plug 'vim-scripts/icalendar.vim'
Plug 'vito-c/jq.vim'
Plug 'w0rp/ale' | runtime config/ale.vim
Plug 'wellle/targets.vim'

call plug#end()

" https://github.com/junegunn/vim-plug/wiki/faq#shouldnt-vim-plug-update-itself-on-plugupdate-like-vundle
delc PlugUpgrade

" =============================================================================
" COLORS
" =============================================================================

" Available colors:
" black | white
" red | dark_red
" yellow | dark_yellow
" cyan | blue
" green
" purple
" comment_grey | cursor_grey | gutter_fg_grey | menu_grey | special_grey | visual_grey
" background | foreground
" vertsplit
let s:colors = onedark#GetColors()

function! s:SetAllHighlights() abort
  " Set system highlights
  call onedark#set_highlight('MatchParen', { 'bg': s:colors.visual_grey })
  call onedark#set_highlight('NonText', { 'fg': s:colors.comment_grey })
  " Set plugin highlights
  let l:callback_args = [function('onedark#set_highlight'), s:colors]
  for [l:key, l:Callback] in items(g:plugin_highlights)
    call call(l:Callback, l:callback_args, {})
  endfor
endfunction

augroup init_colors
  autocmd!
  autocmd ColorScheme * call <SID>SetAllHighlights()
augroup END

colorscheme onedark

" =============================================================================
" MAPPINGS
" =============================================================================

" -----------------------------------------------------------------------------
" MISCELLANEOUS
" -----------------------------------------------------------------------------

" Disable keys
nnoremap <BS> <Nop>
nnoremap <Space> <Nop>

" Clear search highlight
nnoremap <silent> <Leader>/ :nohlsearch<CR>

" Clear all marks
nmap <Leader>m <Plug>MarkClear

" Show syntax higlight groups
nmap <silent> <Leader>s <Plug>SyntaxShowHighlightGroups

" -----------------------------------------------------------------------------
" MOVING
" -----------------------------------------------------------------------------

" Visual line down and up
nnoremap j gj
nnoremap k gk

" Line beginning and end
inoremap <C-H> <C-O>_
inoremap <C-L> <C-O>A

" Jump list
" To be able to use <Tab> and <S-Tab>
nnoremap <silent> <S-Tab> <C-O>

" Buffers
nnoremap <silent> <Leader>] :bnext<CR>
nnoremap <silent> <Leader>[ :bprev<CR>

" Tabs
nnoremap <silent> ]t :tabnext<CR>
nnoremap <silent> [t :tabprev<CR>

" Folds
nnoremap ]z zj
nnoremap [z zk

" Quickfix list
nnoremap <silent> ]q :cnext<CR>
nnoremap <silent> [q :cprev<CR>
nnoremap <silent> ]f :cnfile<CR>
nnoremap <silent> [f :cpfile<CR>

" Location list
nnoremap <silent> ]l :lnext<CR>
nnoremap <silent> [l :lprev<CR>

" -----------------------------------------------------------------------------
" SELECTING
" -----------------------------------------------------------------------------

" Entire file
nnoremap <Leader>a ggVG

" -----------------------------------------------------------------------------
" EDITING
" -----------------------------------------------------------------------------

" Insert new line
nnoremap <Leader>o o<Esc>
nnoremap <Leader>O O<Esc>

" Trigger line completion
inoremap <C-Space> <C-X><C-L>

" Append semicolon to end of line
nnoremap <Leader>; A;<Esc>
vnoremap <silent> <Leader>; :normal A;<CR>

" Append comma to end of line
nnoremap <Leader>, A,<Esc>
vnoremap <silent> <Leader>, :normal A,<CR>

" Copy to system clipboard
nnoremap <Leader>y "*yy
vnoremap <Leader>y "*y

" Paste from system clipboard
nnoremap <leader>p "*p
vnoremap <Leader>p "*p

" -----------------------------------------------------------------------------
" BUFFERS
" -----------------------------------------------------------------------------

" Write buffer
nnoremap <silent> <Leader>w :write<CR>
nnoremap <silent> <Leader>W :wall<CR>

" Refresh buffer
nnoremap <silent> <Leader>r :edit<CR>

" -----------------------------------------------------------------------------
" WINDOWS
" -----------------------------------------------------------------------------

" Split window
nmap <silent> <Leader><Left> <Plug>WindowSplitLeft
nmap <silent> <Leader><Right> <Plug>WindowSplitRight
nmap <silent> <Leader><Up> <Plug>WindowSplitUp
nmap <silent> <Leader><Down> <Plug>WindowSplitDown

" Move around windows
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

" -----------------------------------------------------------------------------
" FILES
" -----------------------------------------------------------------------------

" Print file path
nnoremap <silent> <Leader>. :echo expand('%p')<CR>

" Update and reload configuration
nnoremap <Leader>v :edit $MYVIMRC<CR>
nnoremap <Leader>V :source $MYVIMRC<CR>

" =============================================================================
" FUNCTIONS
" =============================================================================

" Helper to use nvm node for version given, to be called in .lvimrc file
" Node should have neovim package installed: npm install -g neovim
" Example: call g:LocalvimrcNvmNode('20.16.0')
function g:LocalvimrcNvmNode(node_version) abort
  let l:nvm_bin_dir = $HOME . '/.nvm/versions/node/' . a:node_version . '/bin'
  let $PATH = l:nvm_bin_dir . ':' . $PATH
  let g:node_host_prog = l:nvm_bin_dir . '/neovim-node-host'
endfunction
