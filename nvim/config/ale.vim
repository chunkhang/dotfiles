let g:ale_sign_error = '•'
let g:ale_sign_warning = '•'
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_hover_cursor = 0
let g:ale_floating_preview = 1
let g:ale_floating_window_border = [' ', ' ', ' ', ' ', ' ', ' ']
let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 1

let g:ale_linters = {
      \ 'css': ['stylelint'],
      \ 'go': ['gofmt', 'golint', 'go vet'],
      \ 'javascript': ['eslint'],
      \ 'lua': ['luacheck'],
      \ 'php': ['php'],
      \ 'proto': ['protolint'],
      \ 'python': ['flake8', 'pyright'],
      \ 'scss': ['stylelint'],
      \ 'sh': ['shell'],
      \ 'typescript': ['eslint', 'tsserver'],
      \ 'typescriptreact': ['eslint', 'tsserver'],
      \ 'vim': ['vint'],
      \ 'zsh': ['shell'],
      \ }

let g:ale_fixers = {
      \ 'css': ['prettier'],
      \ 'html': ['prettier'],
      \ 'javascript': ['prettier'],
      \ 'json': ['prettier'],
      \ 'markdown': ['prettier'],
      \ 'python': ['black'],
      \ 'scss': ['prettier'],
      \ 'typescript': ['prettier'],
      \ 'typescriptreact': ['prettier'],
      \ 'yaml': ['prettier'],
      \ }

let g:ale_python_pyright_config = {
      \ 'pyright': {
      \   'disableLanguageServices': v:true,
      \ },
      \}

let g:ale_python_black_change_directory = 0

nmap [e <Plug>(ale_previous_wrap_error)
nmap ]e <Plug>(ale_next_wrap_error)
nmap [w <Plug>(ale_previous_wrap_warning)
nmap ]w <Plug>(ale_next_wrap_warning)

nnoremap <silent> <Leader>l :ALELint<CR>
nnoremap <silent> <Leader>f :ALEFix<CR>

function! g:plugin_highlights.ale(set_highlight, colors) dict abort
  call a:set_highlight('ALEWarningSign', { 'fg': a:colors.yellow })
endfunction
