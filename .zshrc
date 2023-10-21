alias vim=nvim
alias ls=exa
alias ll='exa -la'
alias ':q'='exit'

alias ip-public='dig +short myip.opendns.com @resolver1.opendns.com'
alias ip-local="ifconfig en0 | grep 'inet ' | cut -d' ' -f2 | sed 's/addr://' "

# wsl
# if grep -qi microsoft /proc/version; then
#  alias open=explorer.exe
# fi

precmd() { print -rP "%F{8}%~" }
export PROMPT="%F{8}%(!.#.$)%f "
export GPG_TTY=$(tty)

source <(pkgx --shellcode)  #docs.pkgx.sh/shellcode
