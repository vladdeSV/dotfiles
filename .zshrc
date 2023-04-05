alias vim=nvim
alias ls=exa
alias ll='exa -la'
alias ':q'='exit'

# wsl
# if grep -qi microsoft /proc/version; then
#  alias open=explorer.exe
# fi

precmd() { print -rP "%F{8}%~" }
export PROMPT="%F{8}%(!.#.$)%f "
export GPG_TTY=$(tty)

test -d "$HOME/.tea" && source <("$HOME/.tea/tea.xyz/v*/bin/tea" --magic=zsh --silent)
