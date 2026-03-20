fpath+=("$ZDOTDIR/functions")
autoload git_prompt_info suspended_jobs toggle_suspend tmp
setopt prompt_subst interactive_comments hist_ignore_space

PROMPT='%F{12}%1~%f'
PROMPT+='$(git_prompt_info)'
PROMPT+='$(suspended_jobs)'
PROMPT+=' %(!.#.$) '

zle -N toggle_suspend
bindkey '^Z' toggle_suspend
# bind some default key sequences (for WSL)
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey '^[[H'    beginning-of-line
bindkey '^[[F'    end-of-line
bindkey '^[[3~'   delete-char
bindkey '^H'      backward-kill-word

alias ':q'='echo "deprecated: use ^D instead"'
alias public-ip='dig +short myip.opendns.com @resolver1.opendns.com'
alias dush='setopt local_options null_glob; du -sh * .* | sort -h'
alias dc="DC_PROMPT='> ' dc '$HOME/.config/dc/dcrc' -"
alias vimrc="$EDITOR $HOME/.config/vim/vimrc"
alias zshrc="$EDITOR $HOME/.config/zsh/.zshrc"
alias pbcopy='wl-copy'   # mac-alike alias
alias pbpaste='wl-paste'
alias bat='bat --plain'
alias man='MANWIDTH=80 man --nj --nh'
alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'

# if eza is installed
if command -v eza > /dev/null 2>&1; then
  alias ls='eza -a'
  alias ll='eza -la'
  alias tree="eza --tree"
fi

if command -v fzf > /dev/null 2>&1; then
  export FZF_DEFAULT_OPTS="--layout=reverse --border --color=border:8,prompt:15,current-bg:0,current-fg:-1,pointer:15,hl:8,current-hl:15,info:15"
  source <(fzf --zsh)
  bindkey '^R' fzf-history-widget
else
  bindkey '^R' history-incremental-search-backward
fi

export GPG_TTY=$(tty)

# wsl
if [ -s /proc/version ] && grep -qi microsoft /proc/version; then
  alias open=explorer.exe
fi

# macOS
if [ "$(uname)" = "Darwin" ]; then
  alias finder='open -a Finder'
  alias ipl="ipconfig getifaddr en0"
  alias ipp="dig +short myip.opendns.com @resolver1.opendns.com"
  alias day="date +%A"
  alias week="date +%V"
  alias year="date +%Y"

  # easy klog edit
  alias tid='vim + ~/Documents/tid.klg'
fi
