alias vim=nvim
alias ls=exa
alias ll='exa -la'

# wsl
if grep -qi microsoft /proc/version; then
  alias open=explorer.exe
fi

export PS1="\[\033[38;5;8m\]\w\n\\$ \[$(tput sgr0)\]"
export GPG_TTY=$(tty)

test -d "$HOME/.tea" && source /dev/stdin <<<"$("$HOME/.tea/tea.xyz/v*/bin/tea" --magic=bash --silent)"
