#user defined aliases
alias open="xdg-open"
alias down="open ~/Downloads/"
alias fzf="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}' --preview-window=right:65%"
alias clrScreenshots="rm ~/Pictures/*"
alias de="setxkbmap de"
alias en="setxkbmap us"
alias rootDir='cd $(git rev-parse --show-toplevel)'
alias t='tree'

# Git
alias gcm='git commit -m'
alias gpl='git pull'

#Vim
alias vim="nvim"
