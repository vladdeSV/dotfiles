alias vim=nvim
alias ls=exa
alias ll='exa -la'
alias ':q'='exit'

alias ip-public='dig +short myip.opendns.com @resolver1.opendns.com'

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

# bun completions
test -e "${HOME}/.bun/_bun" && source "${HOME}/.bun/_bun"

# iterm2 integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

if [ -d "$HOME/.pkgx/imagemagick.org/v*/bin/" ]; then
  export PATH="$HOME/.pkgx/imagemagick.org/v*/bin/:$PATH"
fi

