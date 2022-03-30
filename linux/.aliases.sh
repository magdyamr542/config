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

#Vim
alias vim="nvim"

# Tmux layouts
alias tvim="tmux source vim-terminal.conf" # vim with two terminals
