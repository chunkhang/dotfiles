let g:clap_layout = { 'relative': 'editor' }
let g:clap_no_matches_msg = 'No matches found'
let g:clap_insert_mode_only = v:true
let g:clap_open_preview = 'never'
let g:clap_prompt_format = '%provider_id%: '
let g:clap_enable_background_shadow = v:false

nnoremap <C-P> :Clap files<CR>
nnoremap <C-B> :Clap buffers<CR>
