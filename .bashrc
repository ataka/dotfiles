# Prompt
export PS1="\u \W$ "

# bash completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# dir alias
blog="$HOME/Documents/blog/"

# Emacs
alias emacs='open /Applications/Emacs.app'
