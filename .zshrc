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

source <(pkgx --shellcode)  #docs.pkgx.sh/shellcode
