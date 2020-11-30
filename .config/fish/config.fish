set -U fish_prompt_pwd_dir_length 0
set -x SHELL /usr/local/bin/fish

# special commands for work
if test -e ~/.extra_commands.sh
  source ~/.extra_commands.sh
end

alias vim nvim                            # In this house we no longer use vim......
alias nano nvim                           # --
alias :q exit                             # Quick-command to exit
alias cat 'bat -p --paging never'         # bat is nice
alias cwd pwd                             # How I prefer to get the working directory
alias cp 'cp -iv'                         # Preferred implementation
alias mv 'mv -iv'                         # --
alias mkdir 'mkdir -pv'                   # --
alias less 'less -FSRXc'                  # Preferred less implementation
alias qfind "find . -name "               # Search for filename in current directory
alias ip 'curl ifconfig.co'               # Get the public IP of the computer
alias local-ip 'ipconfig getifaddr en0'   # Get the local IP of the computer
alias ll 'exa -lgh -s=type --git'         # exa is better than ls. Fite me.
alias tree 'exa --tree -s=type'           # exa's tree output is much easier on the eyes.
alias python python3                      # force using python 3
alias ssh-nokey 'ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no' # ssh with password instead of ssh key

# git shortcuts
alias gs 'git status'
alias ga 'git add'
alias gaa 'git add -A'
alias gd 'git diff'
alias gds='gd --staged'
alias gco='git checkout'
alias gp 'git pull'
alias gc 'git commit -m'

# vagrant shortcuts
alias vu 'vagrant up'
alias vs 'vagrant ssh'
alias vd 'vagrant destroy'
alias vh 'vagrant halt'

# mac specific
if test (uname) = "Darwin"
  alias set-alfred-use-x-multiply 'defaults write com.runningwithcrayons.Alfred-Preferences calculatorXAsMultiply -bool'
  alias add-dock-space "defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type=\"spacer-tile\";}' && killall Dock" # Add a blank-space to the dock.
  alias finder 'open -a Finder .'             # Open Finder in current directory
  alias unfrick-ipad 'sudo killall -STOP -c usbd'
end

begin
    set --local AUTOJUMP_PATH $HOME/.autojump/share/autojump/autojump.fish
    if test -e $AUTOJUMP_PATH
        source $AUTOJUMP_PATH
    end
end
set -g fish_user_paths "/usr/local/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/sbin" $fish_user_paths
