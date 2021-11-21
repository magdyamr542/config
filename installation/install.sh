#!/bin/bash

function doesCommandExist() {
  if ! command -v $1 &> /dev/null ;
  then
      return 1
  else
    return 0
  fi
}


# detect os
isLinux=1
if [[ uname  -eq "Linux" ]]; then
    isLinux=0
fi


# update packages
if [[ $isLinux -eq 0  ]]; then
  echo "Updating packages ..."
  sudo apt-get update
  echo "Upgrading packages ..."
  sudo apt-get upgrade -y
fi


# install vscode if it does not exist
if ! doesCommandExist code; then
  echo "Could not find vscode. installing it ..."
  if [[ $isLinux -eq 0  ]]; then
    source ./vscode-install-linux.sh
  else
    brew install --cask visual-studio-code
  fi
fi

# install vscode extensions.
if [[ ! -f "extensions.txt" ]]; 
  then
    echo  "No ./extensions.txt file. ABORT"
    exit 1
  else
    echo  "Installing vscode extensions"
    cat extensions.txt | xargs -L 1 code --install-extension --force
fi

# install tmux
if ! doesCommandExist tmux; then
  echo "Could not find tmux. installing it ..."
  if [[ $isLinux -eq 0  ]]; then
    source ./tmux-install-linux.sh
  else
    brew install tmux
  fi
fi

#TODO: add tmux config file to where they belong
