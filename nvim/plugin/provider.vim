" Name: provider.vim
" Description: Configure providers with environment variables

if exists('g:loaded_provider')
  finish
endif
let g:loaded_provider = 1

" Node provider
" $ npm install -g neovim
let s:node_bin_dir = getenv('NVIM_NODE_BIN_DIR')
if s:node_bin_dir != v:null
  let $PATH = s:node_bin_dir . ':' . $PATH
  let g:node_host_prog = s:node_bin_dir . '/neovim-node-host'
endif

" Python provider
" $ pip install pynvim
let s:python_bin_dir = getenv('NVIM_PYTHON_BIN_DIR')
if s:python_bin_dir != v:null
  let $PATH = s:python_bin_dir . ':' . $PATH
  let g:python3_host_prog = s:python_bin_dir . '/python3'
endif

" Disable other providers
let g:loaded_python_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_perl_provider = 0
