set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

let $PATH = '/opt/homebrew/opt/node@16/bin' . ':' . $PATH
let g:node_host_prog = '/opt/homebrew/bin/neovim-node-host'

let g:loaded_python_provider = 0
let g:python3_host_prog = '/opt/homebrew/opt/python@3.10/bin/python3'

let g:loaded_ruby_provider = 0

let g:loaded_perl_provider = 0

source ~/.vimrc
