# check if command exists
doesCommandExist () {
  return $(command -v $1 &> /dev/null)
}

pdf() {
    #do things with parameters like $1 such as
    xdg-open "$1"&!
}

opdf() {
    #do things with parameters like $1 such as
    xdg-open "$1"&!
}



# easy cp of file
cpfile () {
  if  doesCommandExist xsel
    then
        file=$(realpath $1)
        cat $file | xsel -b 
    else
      echo "xsel is not installed. please install it first..."
  fi

}

# capture the output of a command to the clipboard
cap () { 
  tee /tmp/capture.out;
  cat /tmp/capture.out | xsel -ib 
} 

# sourcing an env file manually with the env-reader utlity https://github.com/magdyamr542/env-reader
sourceenv() {
 sed '/^#/d;/^[[:space:]]*$/d' "$1" | while read -r line; do export "$line"; done    
}


# see the permissions in a huamn readable format using octal notation
octal () {
if [[ $# -eq 0 ]]; then
  echo "Please provide an octal notation as an argument."
  return 1
fi

if ! [[ "$1" =~ ^[0-7]{1,3}$ ]]; then
  echo "Invalid octal notation."
  return 1
fi

mode="$1"
owner=""
group=""
others=""

# Owner permissions
if [[ "${mode:0:1}" == "7" ]]; then
  owner+="rwx"
elif [[ "${mode:0:1}" == "6" ]]; then
  owner+="rw-"
elif [[ "${mode:0:1}" == "5" ]]; then
  owner+="r-x"
elif [[ "${mode:0:1}" == "4" ]]; then
  owner+="r--"
elif [[ "${mode:0:1}" == "3" ]]; then
  owner+="-wx"
elif [[ "${mode:0:1}" == "2" ]]; then
  owner+="-w-"
elif [[ "${mode:0:1}" == "1" ]]; then
  owner+="--x"
else
  owner+="---"
fi

# Group permissions
if [[ "${mode:1:1}" == "7" ]]; then
  group+="rwx"
elif [[ "${mode:1:1}" == "6" ]]; then
  group+="rw-"
elif [[ "${mode:1:1}" == "5" ]]; then
  group+="r-x"
elif [[ "${mode:1:1}" == "4" ]]; then
  group+="r--"
elif [[ "${mode:1:1}" == "3" ]]; then
  group+="-wx"
elif [[ "${mode:1:1}" == "2" ]]; then
  group+="-w-"
elif [[ "${mode:1:1}" == "1" ]]; then
  group+="--x"
else
  group+="---"
fi

# Others permissions
if [[ "${mode:2:1}" == "7" ]]; then
  others+="rwx"
elif [[ "${mode:2:1}" == "6" ]]; then
  others+="rw-"
elif [[ "${mode:2:1}" == "5" ]]; then
  others+="r-x"
elif [[ "${mode:2:1}" == "4" ]]; then
  others+="r--"
elif [[ "${mode:2:1}" == "3" ]]; then
  others+="-wx"
elif [[ "${mode:2:1}" == "2" ]]; then
  others+="-w-"
elif [[ "${mode:2:1}" == "1" ]]; then
  others+="--x"
else
  others+="---"
fi

echo "$owner$group$others"
}


 fzf-git-branch() {
    git rev-parse HEAD > /dev/null 2>&1 || return

    git branch --color=always --all --sort=-committerdate |
        grep -v HEAD |
        fzf --height 75% --ansi --no-multi --preview-window right:65% \
            --preview 'git log -n 50 --color=always --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed "s/.* //" <<< {})' |
        sed "s/.* //"
}

 gch() {
    git rev-parse HEAD > /dev/null 2>&1 || return

    local branch

    branch=$(fzf-git-branch)
    if [[ "$branch" = "" ]]; then
        echo "No branch selected."
        return
    fi

    # If branch name starts with 'remotes/' then it is a remote branch. By
    # using --track and a remote branch name, it is the same as:
    # git checkout -b branchName --track origin/branchName
    if [[ "$branch" = 'remotes/'* ]]; then
        git checkout --track $branch
    else
        git checkout $branch;
    fi
}

awsExportCredentials () {
  echo Exporting credentials for profile $1
  eval $(aws configure export-credentials --profile $1 --format env)
  if [ "$?" -ne 0 ]; then
     echo "These are the existing profiles"
     aws configure list-profiles
  fi
}
