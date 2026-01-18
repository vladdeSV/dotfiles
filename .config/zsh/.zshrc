export GPG_TTY=$(tty)
export DC_PROMPT="> "

fpath+=("$HOME/.config/zsh/functions")
autoload git_prompt_info

precmd() {
  export PROMPT="%F{12}%1~$(git_prompt_info) %f%(!.#.$)%f "
}

alias ':q'='echo "deprecated: use ^D instead"'
alias public-ip='dig +short myip.opendns.com @resolver1.opendns.com'
alias tmp="cd '$HOME/.local/tmp' && pwd"
alias dush='setopt local_options null_glob; du -sh * .* | sort -h'
alias dc="dc '$HOME/.config/dc/dcrc' -"

# if eza is installed
if command -v eza &> /dev/null; then
  alias ls=eza
  alias ll='eza -la'
  alias tree="eza --tree"
fi

# um... make ^R work again?
bindkey '^R' history-incremental-search-backward
# allow inline comments (with #)
setopt interactivecomments

# wsl
if [ -s /proc/version ] && grep -qi microsoft /proc/version; then
  alias open=explorer.exe
fi

# macOS
if [ "$(uname)" = "Darwin" ]; then
  alias finder 'open -a Finder'
  alias ipl="ipconfig getifaddr en0"
  alias ipp="dig +short myip.opendns.com @resolver1.opendns.com"
  alias day="date +%A"
  alias week="date +%V"
  alias year="date +%Y"

  # easy klog edit
  alias tid='vim + ~/Documents/tid.klg'
fi

# ghostty workaround, to fix errors like "missing or unsuitable terminal: xterm-ghostty"
if [[ "$TERM_PROGRAM" == "ghostty" ]]; then
    export TERM=xterm-256color
fi

