let g:ctrlsf_case_sensitive = 'yes'
let g:ctrlsf_default_root = 'project'
let g:ctrlsf_extra_root_markers = ['.root']
let g:ctrlsf_position = 'right'
let g:ctrlsf_auto_close = {
      \ 'normal': 0,
      \ 'compact': 0
      \ }
let g:ctrlsf_indent = 2
let g:ctrlsf_regex_pattern = 1
let g:ctrlsf_populate_qflist = 1
let g:ctrlsf_ackprg = 'rg'

nmap <C-F>f <Plug>CtrlSFPrompt
nmap <C-F>w <Plug>CtrlSFCwordPath
