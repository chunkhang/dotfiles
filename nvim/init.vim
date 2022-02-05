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
set noautoread
set noshowmode
set noswapfile
set number
set relativenumber
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
let $PATH = 
      \ '/opt/homebrew/opt/node@16/bin:' .
      \ '/opt/homebrew/opt/python@3.10/Frameworks/Python.framework/Versions/3.10/bin:' .
      \ $PATH
let g:node_host_prog = '/opt/homebrew/bin/neovim-node-host'
let g:python3_host_prog = '/opt/homebrew/opt/python@3.10/bin/python3'
let g:loaded_python_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_perl_provider = 0

augroup init_settings
  autocmd!
  " Enable highlight on yank
  autocmd TextYankPost * silent! lua vim.highlight.on_yank {timeout=500}
augroup END

" =============================================================================
" PLUGINS
" =============================================================================

call plug#begin(stdpath('config') . '/plugged')

Plug 'AndrewRadev/splitjoin.vim' | runtime config/splitjoin.vim
Plug 'AndrewRadev/switch.vim' | runtime config/switch.vim
Plug 'Joorem/vim-haproxy'
Plug 'PProvost/vim-markdown-jekyll'
Plug 'SirVer/ultisnips' | runtime config/ultisnips.vim
Plug 'bagrat/vim-buffet' | runtime config/buffet.vim
Plug 'cakebaker/scss-syntax.vim'
Plug 'camspiers/lens.vim'
Plug 'cespare/vim-toml'
Plug 'chemzqm/vim-jsx-improve' | runtime config/javascript.vim
Plug 'chrisbra/Colorizer' | runtime config/colorizer.vim
Plug 'chunkhang/msmtp.vim'
Plug 'chunkhang/vim-mbsync'
Plug 'ctrlpvim/ctrlp.vim' | runtime config/ctrlp.vim
Plug 'dyng/ctrlsf.vim' | runtime config/ctrlsf.vim
Plug 'embear/vim-localvimrc' | runtime config/localvimrc.vim
Plug 'ervandew/supertab'
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
Plug 'kshenoy/vim-signature'
Plug 'leafgarland/typescript-vim'
Plug 'lepture/vim-jinja'
Plug 'ludovicchabant/vim-gutentags' | runtime config/gutentags.vim
Plug 'machakann/vim-swap'
Plug 'maximbaz/lightline-ale'
Plug 'mhinz/vim-signify' | runtime config/signify.vim
Plug 'neomutt/neomutt.vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'plasticboy/vim-markdown' | runtime config/markdown.vim
Plug 'qpkorr/vim-bufkill' | runtime config/bufkill.vim
Plug 'rhysd/conflict-marker.vim'
Plug 'rhysd/git-messenger.vim' | runtime config/git_messenger.vim
Plug 'tommcdo/vim-lion'
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

call plug#end()

" =============================================================================
" COLORS
" =============================================================================

let s:colors = onedark#GetColors()
" Available colors:
" - background
" - black
" - blue
" - comment_grey
" - cursor_grey
" - cyan
" - dark_red
" - dark_yellow
" - foreground
" - green
" - gutter_fg_grey
" - menu_grey
" - purple
" - red
" - special_grey
" - vertsplit
" - visual_grey
" - white
" - yellow

function! s:SetColors() abort

  " matchit.vim
  call onedark#set_highlight('MatchParen', {'bg': s:colors.visual_grey })

  " SirVer/ultisnips
  call onedark#set_highlight('snipLeadingSpaces', {'fg': s:colors.black })

  " cespare/vim-toml
  call onedark#set_highlight('tomlTable', { 'fg': s:colors.blue })

  " chemzqm/vim-jsx-improve
  call onedark#set_highlight('jsDocTags', { 'fg': s:colors.cyan })
  call onedark#set_highlight('jsDocType', { 'fg': s:colors.yellow })
  call onedark#set_highlight('jsDocTypeNoParam', { 'fg': s:colors.yellow })
  call onedark#set_highlight('jsDocParam', { 'fg': s:colors.white })

  " itchyny/lightline
  call onedark#set_highlight('LightlineLeft_active_2', {'fg': s:colors.white })
  call onedark#set_highlight('LightlineMiddle_active', {'fg': s:colors.white })
  call onedark#set_highlight('LightlineRight_active_2', {'fg': s:colors.white })

  " kshenoy/vim-signature
  call onedark#set_highlight('SignatureMarkText', {'fg': s:colors.red })

  " peitalin/vim-jsx-typescript
  call onedark#set_highlight('typescriptParens', { 'fg': s:colors.white })
  call onedark#set_highlight('typescriptStorageClass', { 'fg': s:colors.purple })
  call onedark#set_highlight('typescriptInterpolationDelimiter', { 'fg': s:colors.red })
  call onedark#set_highlight('typescriptNull', { 'fg': s:colors.dark_yellow })
  call onedark#set_highlight('typescriptType', { 'fg': s:colors.dark_yellow })
  call onedark#set_highlight('typescriptGlobalObjects', { 'fg': s:colors.yellow })
  call onedark#set_highlight('typescriptDeprecated', { 'fg': s:colors.blue })
  call onedark#set_highlight('typescriptBranch', { 'fg': s:colors.red })
  call onedark#set_highlight('typescriptLogicSymbols', { 'fg': s:colors.purple })
  call onedark#set_highlight('ReactLifeCycleMethods', { 'fg': s:colors.blue })
  call onedark#set_highlight('ReduxKeywords', { 'fg': s:colors.white })
  call onedark#set_highlight('tsxCloseTag', { 'fg': s:colors.white })

  " plasticboy/vim-markdown
  call onedark#set_highlight('htmlH1', { 'fg': s:colors.red })
  call onedark#set_highlight('htmlH2', { 'fg': s:colors.green })
  call onedark#set_highlight('htmlH3', { 'fg': s:colors.blue })
  call onedark#set_highlight('htmlH4', { 'fg': s:colors.purple })
  call onedark#set_highlight('htmlH5', { 'fg': s:colors.purple })
  call onedark#set_highlight('htmlH6', { 'fg': s:colors.purple })

  " rhysd/git-messenger.vim
  call onedark#set_highlight('gitmessengerPopupNormal', { 'bg': s:colors.menu_grey })
  call onedark#set_highlight('gitmessengerHeader', { 'fg': s:colors.purple })
  call onedark#set_highlight('gitmessengerHash', { 'fg': s:colors.blue })
  call onedark#set_highlight('gitmessengerHistory', { 'fg': s:colors.green })

  " w0rp/ale
  call onedark#set_highlight('ALEWarningSign', { 'fg': s:colors.yellow })

endfunction

" bagrat/vim-buffet
function g:BuffetSetCustomColors() abort
  call onedark#set_highlight('BuffetBuffer', {'bg': s:colors.black, 'fg': s:colors.comment_grey })
  call onedark#set_highlight('BuffetCurrentBuffer', {'bg': s:colors.black })
  call onedark#set_highlight('BuffetActiveBuffer', {'bg': s:colors.black, 'fg': s:colors.comment_grey })
  call onedark#set_highlight('BuffetTab', {'bg': s:colors.black, 'fg': s:colors.blue })
  call onedark#set_highlight('BuffetTrunc', {'bg': s:colors.black })
endfunction

augroup init_colors
  autocmd!
  autocmd ColorScheme * call <SID>SetColors()
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

" Reload configuration
nnoremap <Leader>v :source $MYVIMRC<CR>
