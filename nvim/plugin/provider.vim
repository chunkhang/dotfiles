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
function g:ConfigureNodeProvider(bin_dir) abort
  if a:bin_dir != v:null
    let $PATH = a:bin_dir . ':' . $PATH
    let g:node_host_prog = a:bin_dir . '/neovim-node-host'
  endif
endfunction

" Python provider
" Note: pip install pynvim
function g:ConfigurePythonProvider(bin_dir) abort
  if a:bin_dir != v:null
    let $PATH = a:bin_dir . ':' . $PATH
    let g:python3_host_prog = a:bin_dir . '/python3'
  endif
endfunction

" Configure functions are called automatically when plugin is loaded
" Additionally, they can be also be called manually in .lvimrc file
" Example:
"   if !g:localvimrc_sourced_once
"     call g:ConfigureNodeProvider($HOME . '/.nvm/versions/node/v22.8.0/bin')
"   endif
call g:ConfigureNodeProvider(getenv('NVIM_NODE_BIN_DIR'))
call g:ConfigurePythonProvider(getenv('NVIM_PYTHON_BIN_DIR'))
