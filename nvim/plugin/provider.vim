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

function s:ConfigureProvider(var, bin, dir) abort
  if !isdirectory(a:dir)
    echoerr 'provider.vim: Expected directory, but got: ' . a:dir
    return
  endif

  " Add path for bin directory
  let $PATH = a:bin . ':' . $PATH

  " Set host program binary from bin directory
  let l:val = a:dir . '/' . a:bin
  execute 'let' a:var '=' string(l:val)
endfunction

" Node provider
" Note: npm install -g neovim
function g:ConfigureNodeProvider(dir) abort
  call s:ConfigureProvider('g:node_host_prog', 'neovim-node-host', a:dir)
endfunction

" Python provider
" Note: pip install pynvim
function g:ConfigurePythonProvider(dir) abort
  call s:ConfigureProvider('g:python3_host_prog', 'python3', a:dir)
endfunction

" Configure functions are called automatically when plugin is loaded
" Additionally, they can be also be called manually in .lvimrc file
" Example:
"   if !g:localvimrc_sourced_once
"     call g:ConfigureNodeProvider($HOME . '/.nvm/versions/node/v22.8.0/bin')
"   endif
call g:ConfigureNodeProvider(getenv('NVIM_NODE_BIN_DIR'))
call g:ConfigurePythonProvider(getenv('NVIM_PYTHON_BIN_DIR'))
