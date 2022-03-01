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

function! s:HighlightCallback(set_highlight, colors) abort
  call a:set_highlight('gitmessengerPopupNormal', { 'bg': a:colors.cursor_grey })
  call a:set_highlight('gitmessengerHeader', { 'fg': a:colors.purple })
  call a:set_highlight('gitmessengerHash', { 'fg': a:colors.blue })
  call a:set_highlight('gitmessengerHistory', { 'fg': a:colors.green })
endfunction
call g:AddHighlightCallback(function('<SID>HighlightCallback'))
