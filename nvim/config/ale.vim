let g:ale_sign_error = '•'
let g:ale_sign_warning = '•'
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_hover_cursor = 0
let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 1

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
      \ 'proto': ['protolint'],
      \ 'php': ['php'],
      \ }

let g:ale_fixers = {
      \ 'yaml': ['prettier'],
      \ 'javascript': ['prettier'],
      \ 'css': ['prettier'],
      \ 'scss': ['prettier'],
      \ 'json': ['prettier'],
      \ 'markdown': ['prettier'],
      \ 'python': ['black'],
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
