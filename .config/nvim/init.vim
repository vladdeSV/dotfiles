set notermguicolors 
"colorscheme vim

function! SetHighlights()
  if &background == "dark"
    hi LineNr ctermfg=7
    hi Visual ctermfg=15 ctermbg=8
    hi Statement ctermfg=11 cterm=NONE
    hi Type ctermfg=121 cterm=NONE
    hi PreProc ctermfg=81
    hi Constant ctermfg=13
    hi Comment ctermfg=14
    hi String ctermfg=13
    hi Identifier ctermfg=14 cterm=bold
    hi ModeMsg ctermfg=NONE cterm=bold
  elseif &background == "light"
    hi LineNr ctermfg=7
    hi Visual ctermfg=0 ctermbg=7
    hi Statement ctermfg=130 cterm=NONE
    hi Type ctermfg=2 cterm=NONE
    hi PreProc ctermfg=5
    hi Constant ctermfg=1
    hi Comment ctermfg=4
    hi String ctermfg=1
    hi Identifier ctermfg=6 cterm=NONE
    hi ModeMsg ctermfg=NONE cterm=bold
  endif
endfunction

autocmd OptionSet background call SetHighlights()

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

" map Ctrl+C to yank to clipboard
" (can't figure out how to do ⌘+C on iTerm2 (also this is more cross-platform since my non-mac machines don't have ⌘))
nnoremap <C-c> "+y
vnoremap <C-c> "+y

nnoremap <C-b> :NvimTreeToggle<Enter>
vnoremap <C-b> :NvimTreeToggle<Enter>

language en_us
set spelllang=en_us,sv
autocmd FileType markdown,klog setlocal spell
autocmd FileType markdown,klog setlocal complete+=kspell

" klog
au BufRead,BufNewFile *.klg set filetype=klog
command! Kdate execute "normal! o" . strftime("%Y-%m-%d") . " (8h!)" . "\n\t08:00 - ? "
autocmd BufWritePre *.klg if getline('$') !=# '' | call append('$', '') | endif

lua require('init')

