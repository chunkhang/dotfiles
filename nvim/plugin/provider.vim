" Name: provider.vim
" Description: Configure providers

if exists('g:loaded_provider')
  finish
endif
let g:loaded_provider = 1

" Disable certain providers
let g:loaded_python_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_perl_provider = 0

" Node provider
" Note: npm install -g neovim
function g:ConfigureNodeProvider() abort
  let s:node_bin_dir = getenv('NVIM_NODE_BIN_DIR')
  if s:node_bin_dir != v:null
    let $PATH = s:node_bin_dir . ':' . $PATH
    let g:node_host_prog = s:node_bin_dir . '/neovim-node-host'
  endif
endfunction

" Python provider
" Note: pip install pynvim
function g:ConfigurePythonProvider() abort
  let s:python_bin_dir = getenv('NVIM_PYTHON_BIN_DIR')
  if s:python_bin_dir != v:null
    let $PATH = s:python_bin_dir . ':' . $PATH
    let g:python3_host_prog = s:python_bin_dir . '/python3'
  endif
endfunction


" Configure functions are called automatically when plugin is loaded
" Additionally, they can be also be called manually in .lvimrc file
" Example:
"   if !g:localvimrc_sourced_once
"     let $NVIM_NODE_BIN_DIR = $HOME . '/.nvm/versions/node/v22.8.0/bin'
"     call g:ConfigureNodeProvider()
"   endif
call g:ConfigureNodeProvider()
call g:ConfigurePythonProvider()
