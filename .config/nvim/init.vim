" editor general
set tabstop=8
set softtabstop=2
set shiftwidth=2
set expandtab
set number
set numberwidth=4
set scrolloff=3
set nowrap
set smartcase
set linebreak
set spelllang=en_us
set laststatus=2
set statusline=%f%=(%l,%c)
map q <Nop> " ignore just a q press. h*ck i dislike this command...

hi LineNr ctermfg=7
hi Visual ctermbg=15

" map Ctrl+C to yank to clipboard
" (can't figure out how to do ⌘+C on iTerm2 (also this is more cross-platform since my non-mac machines don't have ⌘))
nnoremap <C-c> "+y
vnoremap <C-c> "+y
" set clipboard+=unnamedplus " i think this merges my clipboard with vim's. unsure if i want that.

language en_US
autocmd FileType markdown setlocal spell
autocmd FileType markdown setlocal complete+=kspell

" klog
au BufRead,BufNewFile *.klg set filetype=klog
command! Kdate execute "normal a" . strftime("%Y-%m-%d") . " (8h!)"
autocmd BufWritePre *.klg if getline('$') !=# '' | call append('$', '') | endif

lua require('init')

