command! KlogDate call KlogDate()
command! KlogOpenRange call KlogOpenRange()
command! KlogCloseRange call KlogCloseRange()
autocmd FileType klog nnoremap <buffer> <leader>kd :call KlogDate()<CR>
autocmd FileType klog nnoremap <buffer> <leader>ke :call KlogOpenRange()<CR>
autocmd FileType klog nnoremap <buffer> <leader>kc :call KlogCloseRange()<CR>
function! KlogDate()
  if getline(".") !=# ""
    execute "normal! A\n"
  endif

  execute "normal! A\n" . strftime("%Y-%m-%d") . "\n\t08:00 - ? \<Esc>"
endfunction

function KlogDetectIndentation()
  let l:save_pos = getcurpos()
  silent! execute '?^\d\d\d\d-\d\d-\d\d\|^\s*$'

  if getline('.')!~#'^\d\d\d\d-\d\d-\d\d'
    call setpos('.', l:save_pos)
    return ""
  endif

  let l:current_pos = getcurpos()
  for lnum in range(l:current_pos[1], l:save_pos[1])
    let l:line_text = getline(lnum)
    if l:line_text =~# '^\(\t\|    \|  \)'
      call setpos('.', l:save_pos)
      return matchstr(l:line_text, "^\\(\t\\|    \\|  \\)")
    endif
  endfor

  return ""
endfunction

function! KlogOpenRange()
  let l:indentation = KlogDetectIndentation()
  if l:indentation == ""
    echo "klog: can't detect indentation"
    return
  endif

  let l:time = KlogRoundedTimeHalfHour()
  execute "silent! s/\?/" . l:time . "/"
  call append(line('.'), l:indentation . l:time . " - ? ")
  execute "normal! j$\<Esc>"
endfunction

function! KlogRoundedTimeHalfHour()
  let l:hour = str2nr(strftime('%H'))
  let l:min  = str2nr(strftime('%M'))

  if l:min < 15
    let l:min = 0
  elseif l:min < 45
    let l:min = 30
  else
    let l:min = 0
    let l:hour += 1
    if l:hour == 24
      let l:hour = 0
    endif
  endif

  let l:rounded_time = printf('%02d:%02d', l:hour, l:min)
  return l:rounded_time
endfunction

function! KlogCloseRange()
  let l:time = KlogRoundedTimeHalfHour()
  execute "s/\?/" . l:time . "/"
endfunction
