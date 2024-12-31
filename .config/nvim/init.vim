source ~/.config/nvim/vundle_plugins.vim

language en_us
let mapleader = ","
set notermguicolors

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
" thank you @saccarosium for this workaround
autocmd ColorSchemePre * call s:check_background()

" yank to clipboard
vnoremap <leader>c "+y
noremap <leader>t :call ToggleBackground()<CR>

" klog
autocmd BufRead,BufNewFile *.klg set filetype=klog
autocmd BufWritePre *.klg if getline('$') !=# '' | call append('$', '') | endif
command! Kdate execute "normal! o" . strftime("%Y-%m-%d") . " (8h!)" . "\n\t08:00 - ? "

function s:check_background()
  " echo "run"
  let macos_theme = system("defaults read -g AppleInterfaceStyle 2>/dev/null")
  if macos_theme ==# ''
    set background=light
  else
  "   set background=dark
  endif
endfunction

colorscheme vim
