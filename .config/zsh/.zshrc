export GPG_TTY=$(tty)

fpath+=("$HOME/.config/zsh/functions")
autoload git_prompt_info

precmd() {
  export PROMPT="%F{12}%1~$(git_prompt_info) %f%(!.#.$)%f "
}

alias ':q'='echo "deprecated: use ^D instead"'
alias public-ip='dig +short myip.opendns.com @resolver1.opendns.com'
alias tmp='cd ~/.local/tmp && pwd'

if command -v eza &> /dev/null; then
  alias ls=eza
  alias ll='eza -la'
  alias tree="eza --tree"
fi

# um... make ^R work again?
bindkey -v
bindkey '^R' history-incremental-search-backward

# wsl
if [ -s /proc/version ] && grep -qi microsoft /proc/version; then
  alias open=explorer.exe
fi

# macOS
if [ "$(uname)" = "Darwin" ]; then
  alias finder 'open -a Finder .'
  alias local-ip="ifconfig en0 | grep 'inet ' | cut -d' ' -f2 | sed 's/addr://' "
  alias day="date +%A"
  alias week="date +%V"
  alias year="date +%Y"

  # easy klog edit
  alias tid='vim +$ ~/Documents/tid.klg'
fi

# ghostty workaround, to fix errors like "missing or unsuitable terminal: xterm-ghostty"
if [[ "$TERM_PROGRAM" == "ghostty" ]]; then
    export TERM=xterm-256color
fi

