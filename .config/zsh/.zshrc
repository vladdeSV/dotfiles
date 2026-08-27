if [ -s /etc/profile ]; then
  source /etc/profile
fi

fpath+=("$ZDOTDIR/functions")
autoload git_prompt_info suspended_jobs toggle_suspend open_prev_suspended tmp clear_screen
setopt prompt_subst interactive_comments hist_ignore_space no_nomatch

PROMPT='%F{12}%1~%f'
PROMPT+='$(git_prompt_info)'
PROMPT+='$(suspended_jobs)'
PROMPT+=' %(!.#.$) '

zle -N toggle_suspend
zle -N open_prev_suspended
zle -N clear_screen
bindkey '^Z' toggle_suspend
bindkey '^\\' open_prev_suspended # this is the key left of Z for me
bindkey '^L' clear_screen
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
alias man='MANWIDTH=80 man --nj --nh'
alias dev="cd $HOME/dev" # i always have a ~/dev for development

is_installed() {
  command -v "$1" > /dev/null 2>&1
}

if is_installed eza; then
  alias ls='eza -a'
  alias ll='eza -la'
  alias tree="eza --tree"
fi

if is_installed rg; then
  source <(rg --generate complete-zsh)
fi

if is_installed bat; then
  alias bat='bat --plain'
  alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if is_installed fzf; then
  export FZF_DEFAULT_OPTS="--layout=reverse --border --color=border:8,prompt:15,current-bg:0,current-fg:-1,pointer:15,hl:8,current-hl:15,info:15"
  source <(fzf --zsh)
  bindkey '^R' fzf-history-widget
else
  bindkey '^R' history-incremental-search-backward
fi

export GPG_TTY=$(tty)

# wsl
if [ -n "$WSL_DISTRO_NAME" ]; then
  alias open=explorer.exe
  alias copy=clip.exe

  trap 'exit 0' EXIT # wip: workaround when prev command failed and i do ^D

  function uuid() {
    uuid=$(uuidgen)
    printf "$uuid\n"
    printf "$uuid" | clip.exe
    >&2 printf "(copied to clipboard)\n"
  }
  alias guid=uuid
fi

# bun completions
if [ -d "$HOME/.bun" ]; then
  export BUN_INSTALL="$HOME/.bun"
  path+=("$BUN_INSTALL/bin")
  [ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"
fi

# swift
if [ -s "$HOME/.local/share/swiftly/env.sh" ]; then
  source "$HOME/.local/share/swiftly/env.sh"
fi

[ -s "$ZDOTDIR/local.zsh" ] && source "$ZDOTDIR/local.zsh"
