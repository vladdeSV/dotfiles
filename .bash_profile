# If SSH connection, display hostname
if [ "$SSH_CONNECTION" ]; then
    host=' \[\033[38;5;11m\]\h'
else
    host=''
fi

# Set the prompt
export PS1="\[\033[38;5;10m\]\u$host\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;45m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\] \\$ \[$(tput sgr0)\]"

# Load scripts if existing
if [ -f /usr/local/bin/git-completion.bash ];   then . /usr/local/bin/git-completion.bash;   else echo "> git-completion.bash not found"; fi
if [ -f /usr/local/etc/profile.d/autojump.sh ]; then . /usr/local/etc/profile.d/autojump.sh; else echo "> autojump.sh not found"; fi

# Auto-complete symlinks
bind 'set mark-symlinked-directories on'
# Auto-complete case-insensetive
bind 'set completion-ignore-case on'

# Quick-command to exit
alias qq=exit

# By coincidence, the word 'pull' (from `git pull`) is very similar to the Swedish word 'pulla', which is used to describe women masturbating.
# So by aliasing git to my girlfriend's name, I can also have a laugh when I fetch and merge repositories :^)
alias bea=git

# How I prefer to get the working directory
alias cwd=pwd

# from that guy Nate
alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -pv'
alias ll='ls -FGlAhp'
alias cd..='cd ../'
alias ..='cd ../'
alias ...='cd ../../'
alias finder='open -a Finder ./'
alias ~="cd ~"
alias which='type -all'
alias path='echo -e ${PATH//:/\\n}'
mcd () { mkdir -p "$1" && cd "$1"; }
trash () { command mv "$@" ~/.Trash ; }
zipf () { zip -r "$1".zip "$1" ; }
extract () {
	if [ -f $1 ] ; then
	  case $1 in
		*.tar.bz2)   tar xjf $1     ;;
		*.tar.gz)    tar xzf $1     ;;
		*.bz2)       bunzip2 $1     ;;
		*.rar)       unrar e $1     ;;
		*.gz)        gunzip $1      ;;
		*.tar)       tar xf $1      ;;
		*.tbz2)      tar xjf $1     ;;
		*.tgz)       tar xzf $1     ;;
		*.zip)       unzip $1       ;;
		*.Z)         uncompress $1  ;;
		*.7z)        7z x $1        ;;
		*)     echo "'$1' cannot be extracted via extract()" ;;
		 esac
	 else
		 echo "'$1' is not a valid file"
	 fi
}

# I took inspiration from https://frd.mn/ and https://natelandau.com/ :pray: