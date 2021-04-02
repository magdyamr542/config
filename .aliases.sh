# System
alias clrd=" . ~/Desktop/scripts/clear-downloads-dir/clear-downloads-dir.sh"
alias down=" open  ~/Downloads"
alias ip="ipconfig getifaddr en0"
alias ipglob="dig +short myip.opendns.com @resolver1.opendns.com"
alias wifihosts="nmap -sn 192.168.178.38/24 | grep MAC | tr -s ' ' | cut -d ' ' -f 4-"
#Daily Usage
alias youtube="open http://www.youtube.com"
alias google=". ~/Desktop/scripts/search-google/search-google.sh"
alias facebook="open http://www.facebook.com"
alias whatsapp="open https://web.whatsapp.com"
alias instagram="open https://www.instagram.com"
alias github="open https://github.com/"
#Github Api
alias createRepo="cd ~/Desktop/scripts/create-github-repo && ./createRepo.sh"
alias deleteRepo="cd ~/Desktop/scripts/delete-github-repo && ./deleteRepo.sh"
