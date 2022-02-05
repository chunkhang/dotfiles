let g:ctrlp_root_markers = ['.root']
let g:ctrlp_use_caching = 1
let g:ctrlp_prompt_mappings = {
      \ 'PrtHistory(1)': [],
      \ 'PrtClearCache()': ['<c-p>'],
      \ }
let g:ctrlp_open_multiple_files = 'i'
let g:ctrlp_user_command = 'rg %s --files --color=never'
