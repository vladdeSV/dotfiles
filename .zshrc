alias vim=nvim
alias ls=exa
alias ll='exa -la'
alias ':q'='exit'

alias ip-public='dig +short myip.opendns.com @resolver1.opendns.com'

export GPG_TTY=$(tty)

# easy klog edit
alias tid='nvim +$ ~/Documents/tid.klg +"set syntax=klog"'

# wsl
if [ -s /proc/version ] && grep -qi microsoft /proc/version; then
  alias open=explorer.exe
fi

# macOS
if [ "$(uname)" = "Darwin" ]; then
  alias finder 'open -a Finder .'
  alias ip-local="ifconfig en0 | grep 'inet ' | cut -d' ' -f2 | sed 's/addr://' "
  alias day="date +%A"
  alias week="date +%V"
  alias year="date +%Y"
fi

# bun
if [ -d "$HOME/.bun" ]; then
    export BUN_INSTALL="$HOME/.bun"
    export PATH="$BUN_INSTALL/bin:$PATH"
    [ -e "${HOME}/.bun/_bun" ] && source "${HOME}/.bun/_bun"
fi

# iterm2 integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# git in prompt
git_prompt_info() {
  if git rev-parse --is-inside-work-tree &>/dev/null; then

    dynamic=""
    dynamic+="%f("
    dynamic+="%F{11}$(git symbolic-ref --short HEAD)%f"
    
    if [[ -n $(git diff --cached) ]]; then
      dynamic+="%F{9}"
      dynamic+="?"
    fi

    if [[ -n $(git diff) ]]; then
      dynamic+="%F{9}"
      dynamic+="!"
    fi

    if [[ -n $(git ls-files --others --exclude-standard) ]]; then
      dynamic+="%F{8}"
      dynamic+="."
    fi

    dynamic+="%f)"


    echo -n "$dynamic"
  fi
}

precmd() {
  export PROMPT="%F{12}%1~$(git_prompt_info) %f%(!.#.$)%f "
}
