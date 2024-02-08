" sidebar numbers
set number
set numberwidth=4

" editor general
set scrolloff=3
set nowrap
set smartcase
set mouse=
set linebreak
set spelllang=en_us
autocmd FileType markdown setlocal spell
autocmd FileType markdown setlocal complete+=kspell

" tabs
set tabstop=8
set softtabstop=2
set shiftwidth=2
set expandtab

" statusline
set laststatus=2
set statusline=(%l,%c)\ %F

" ignore just a q press. h*ck i dislike this command...
map q <Nop>

au BufRead,BufNewFile *.klg set filetype=klog

" destroy all software
colorscheme garybernhardt
