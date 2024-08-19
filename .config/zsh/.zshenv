# paths
declare -A paths
paths[brew]="/opt/homebrew/bin/brew"
paths[jetbrains]="$HOME/Library/Application Support/JetBrains/Toolbox/scripts"
paths[bun]="$HOME/.bun"
paths[iterm2]="$HOME/.iterm2_shell_integration.zsh"

# brew
if [ -x "${paths[brew]}" ]; then
  eval "$(${paths[brew]} shellenv)"
fi

# jetbrains toolbox
if [ -d "${paths[jetbrains]}" ]; then
  export PATH="$PATH:${paths[jetbrains]}"
fi

# iterm2 integration
if [ -e "${paths[iterm2]}" ]; then
  source "${paths[iterm2]}"
fi

# bun
if [ -d "${paths[bun]}" ]; then
    export BUN_INSTALL="${paths[bun]}"
    export PATH="$PATH:$BUN_INSTALL/bin"

    if [ -e "${BUN_INSTALL}/_bun" ]; then
        source "${BUN_INSTALL}/_bun"
    fi
fi

unset paths
