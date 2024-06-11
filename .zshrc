alias vim=nvim
alias ls=exa
alias ll='exa -la'
alias ':q'='exit'

alias ip-public='dig +short myip.opendns.com @resolver1.opendns.com'
alias ip-local="ifconfig en0 | grep 'inet ' | cut -d' ' -f2 | sed 's/addr://' "


export PROMPT="%F{4}%1~ %F{8}%#%f "
export GPG_TTY=$(tty)

# pkgx
if command -v pkgx &> /dev/null; then
  source <(pkgx --shellcode) #docs.pkgx.sh/shellcode
fi

# wsl
if [ -s /proc/version ] && grep -qi microsoft /proc/version; then
  alias open=explorer.exe
fi

# macOS
if [ "$(uname)" = "Darwin" ]; then
  alias finder 'open -a Finder .'
  alias ip-local="ifconfig en0 | grep 'inet ' | cut -d' ' -f2 | sed 's/addr://' "
  alias week="date +%V"
fi
