language en_us
let mapleader = ","
set notermguicolors
" colorscheme vim

" editor general
set tabstop=8
set softtabstop=2
set shiftwidth=2
set textwidth=0
set expandtab
set number
set numberwidth=4
set scrolloff=3
set nowrap
set smartcase
set linebreak
set laststatus=2
set statusline=%f%=(%l,%c)
set spelllang=en_us
autocmd FileType markdown setlocal spell
autocmd FileType markdown setlocal complete+=kspell
" ignore just a q press. h*ck i dislike this command...
map q <Nop>
" disable "comment continuation" (gets overridden on load, have to resort to this)
autocmd FileType * set formatoptions-=ro

" yank to clipboard
vnoremap <leader>c "+y
noremap <leader>t :call ToggleBackground()<CR>

" klog
autocmd BufRead,BufNewFile *.klg set filetype=klog
autocmd BufWritePre *.klg if getline('$') !=# '' | call append('$', '') | endif
command! Kdate execute "normal! o" . strftime("%Y-%m-%d") . " (8h!)" . "\n\t08:00 - ? "

" makeshift vim colorscheme
autocmd OptionSet background call SetHighlights()
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

function! ToggleBackground()
  if &background == 'dark'
    set background=light
  else
    set background=dark
  endif
endfunction
