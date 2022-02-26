# System
alias clrd="rm -rf ~/Downloads/*"
alias clrtrash="rm -rf ~/.Trash/*"
alias down=" open  ~/Downloads"
alias iploc="ipconfig getifaddr en0"
alias wifihosts="nmap -sn 192.168.178.38/24 | grep MAC | tr -s ' ' | cut -d ' ' -f 4-"
#Daily Usage
alias t="tree"
alias youtube="open http://www.youtube.com"
alias fzf="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}' --preview-window=right:65%"

alias genc="/usr/local/Cellar/genact/0.11.0/bin/genact"
alias vim="nvim"


# Git
alias gpl="git pull"
alias gcm="git commit -m"
alias glc='git add .; git commit --amend --no-edit' # add changes to last commit (glc git last commit)
