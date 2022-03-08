let g:git_messenger_no_default_mappings = v:true
let g:git_messenger_always_into_popup = v:true

function! s:SetupGitMessengerPopup() abort
    nmap <buffer> <Tab> o
    nmap <buffer> <S-Tab> O
endfunction

augroup config_git_messenger
  autocmd FileType gitmessengerpopup call <SID>SetupGitMessengerPopup()
augroup END

nmap <Leader>b <Plug>(git-messenger)

function! g:plugin_highlights.git_messenger(set_highlight, colors) dict abort
  call a:set_highlight('gitmessengerHeader', { 'fg': a:colors.purple })
  call a:set_highlight('gitmessengerHash', { 'fg': a:colors.blue })
  call a:set_highlight('gitmessengerHistory', { 'fg': a:colors.green })
endfunction
