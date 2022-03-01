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

function! s:HighlightCallback(set, colors) abort
  call a:set('gitmessengerPopupNormal', { 'bg': a:colors.cursor_grey })
  call a:set('gitmessengerHeader', { 'fg': a:colors.purple })
  call a:set('gitmessengerHash', { 'fg': a:colors.blue })
  call a:set('gitmessengerHistory', { 'fg': a:colors.green })
endfunction
call g:AddHighlightCallback(function('<SID>HighlightCallback'))
