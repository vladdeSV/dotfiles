filetype off
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin('~/.config/nvim/bundle')
Plugin 'VundleVim/Vundle.vim'
" ---
Plugin 'ntpeters/vim-better-whitespace'
" ---
call vundle#end()
filetype plugin indent on

" dim highlight of trailing whitespace
highlight ExtraWhitespace ctermbg=7
