#user defined aliases
alias open="xdg-open"
alias down="open ~/Downloads/"
alias fzf="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}' --preview-window=right:65%"
alias clrScreenshots="rm ~/Pictures/*"
alias de="setxkbmap de"
alias en="setxkbmap us"
alias ar="setxkbmap ar"
alias rootDir='cd $(git rev-parse --show-toplevel)'
alias t='tree'

# Git
alias gcm='git commit -m'
alias gpl='git pull'
alias glc='git add .; git commit --amend --no-edit' # add changes to last commit (glc git last commit)
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"

#Vim
alias vim="nvim"

# Tmux layouts
alias tvim="tmux source vim-terminal.conf" # vim with two terminals


# Using astah
alias java8="sdk use java 8.0.322.fx-zulu"
alias java11="sdk use java 11.0.14.10.1-amzn"

# Using kubernetes
alias k="kubectl"


# new docker compose
alias docker-compose="docker compose"

alias clrd="rm -rf ~/Downloads/*"
