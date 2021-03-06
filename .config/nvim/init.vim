" sidebar numbers
set number
set relativenumber
set numberwidth=4
" editor general
set scrolloff=3
set nowrap
set smartcase
" tabs
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" statusline
set laststatus=2
set statusline=
set statusline+=\ [%l,%c]
set statusline+=\ %F

" preferred behaviour
nnoremap d "_d
vnoremap d "_d

" ignore just a q press. h*ck i dislike this command...
map q <Nop>

" ctrl+space (on mac) to autocomplete
inoremap <C-@> <C-N>

" recognize .fish files
au BufRead,BufNewFile *.fish set filetype=fish

colorscheme garybernhardt
