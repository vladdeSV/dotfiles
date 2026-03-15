export GPG_TTY=$(tty)

fpath+=("$HOME/.config/zsh/functions")
autoload git_prompt_info

precmd() {
  export PROMPT="%F{12}%1~$(git_prompt_info) %f%(1j.%F{13}* %f.)%(!.#.$)%f "
}

setopt interactivecomments # allow inline comments (with #)
setopt histignorespace # ignore commands with leading space

# ^Z toggles between suspend and resume
fg-bg() {
  local suspended=${(M)#jobstates:#suspended:*}
  if (( suspended )); then
    zle push-input
    zle -I; fg
  else
    zle suspend
  fi
}
zle -N fg-bg
bindkey '^Z' fg-bg

# simple move back- and forewards
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey '^H' backward-kill-word

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

tmp() {
  local dir
  dir=$(mktemp -d ${1:+"/tmp/${1}.XXXXXXXXXX"}) || return 1
  echo "$dir"
  cd "$dir"
}

# if eza is installed
if command -v eza > /dev/null 2>&1; then
  alias ls='eza -a'
  alias ll='eza -la'
  alias tree="eza --tree"
fi

if command -v fzf > /dev/null 2>&1; then
  source <(fzf --zsh)
  bindkey '^R' fzf-history-widget
else
  bindkey '^R' history-incremental-search-backward
fi

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

