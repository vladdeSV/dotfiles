hi LineNr ctermfg=darkgray

function! s:update_statusline_colors()
  if &background ==# 'light'
    hi StatusLine ctermfg=253 ctermbg=237
    hi StatusLineNC ctermfg=254 ctermbg=245
  else
    hi StatusLine ctermfg=237 ctermbg=251
    hi StatusLineNC ctermfg=245 ctermbg=254
  endif
endfunction

call s:update_statusline_colors()

augroup UpdateStatuslineOnBGChange
  autocmd!
  autocmd OptionSet background call s:update_statusline_colors()
augroup END

