# System
alias oracleSql="cd /Applications/SQLDeveloper.app/Contents/Resources/sqldeveloper && zsh sqldeveloper.sh"
alias clrd=" bash ~/Desktop/scripts/clear-downloads-dir/clear-downloads-dir.sh"
alias clrtrash="rm -rf ~/.Trash/*"
alias down=" open  ~/Downloads"
alias cpfile="bash ~/Desktop/scripts/copy-file-content/copy-file-content.sh"
alias iploc="ipconfig getifaddr en0"
alias ipglob="dig +short myip.opendns.com @resolver1.opendns.com"
alias wifihosts="nmap -sn 192.168.178.38/24 | grep MAC | tr -s ' ' | cut -d ' ' -f 4-"
#Daily Usage
alias t="tree"
alias youtube="open http://www.youtube.com"
alias google=". ~/Desktop/scripts/search-google/search-google.sh"
alias facebook="open http://www.facebook.com"
alias whatsapp="open https://web.whatsapp.com"
alias instagram="open https://www.instagram.com"
alias github="open https://github.com/"
alias fzf="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"

#Github Api
alias createRepo="bash  ~/Desktop/scripts/create-github-repo/createRepo.sh"
alias deleteRepo="bash ~/Desktop/scripts/delete-github-repo/deleteRepo.sh"
