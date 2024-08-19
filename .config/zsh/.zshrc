export GPG_TTY=$(tty)

fpath+=("$HOME/.config/zsh/functions")
autoload git_prompt_info

precmd() {
  export PROMPT="%F{12}%1~$(git_prompt_info) %f%(!.#.$)%f "
}

alias vim=nvim
alias ls=eza
alias ll='eza -la'
alias ':q'='exit'
alias public-ip='dig +short myip.opendns.com @resolver1.opendns.com'

if command -v eza &> /dev/null; then
  alias ls=eza
  alias ll='eza -la'
fi

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
  alias tid='nvim +$ ~/Documents/tid.klg +"set syntax=klog"'
fi

