if [ -x "$(command -v nvim)" ]; then
  export EDITOR=nvim
elif [ -x "$(command -v vim)" ]; then
  export EDITOR=vim
fi
