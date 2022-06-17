augroup config_commentary
  autocmd!
  autocmd FileType jinja,jinja.html setlocal commentstring={#\ %s\ #}
  autocmd FileType vue,sbt setlocal commentstring=\/\/\ %s
  autocmd FileType hocon setlocal commentstring=#\ %s
  autocmd FileType sql setlocal commentstring=--\ %s
  autocmd FileType php setlocal commentstring=\/\/\ %s
  autocmd BufEnter *.tsx setlocal commentstring=\/\/\ %s
augroup END
