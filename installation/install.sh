#!/bin/bash

function isLinux() {
  if [[ uname == "Linux" ]]; then
    return 0
  else
    return 1
  fi
}

function doesCommandExist() {
  if ! command -v $1 &> /dev/null ;
  then
      return 1
  else
    return 0
  fi
}


if ! doesCommandExist code; then
  echo "Could not find VSCODE. installing it ..."
  if isLinux; then
    echo 
  else
    echo "mac install vscode"
    brew install --cask visual-studio-code
  fi
fi

# install vscode extensions
if [[ ! -f "extensions.txt" ]]; 
  then
    echo  "No ./extensions.txt file. ABORT"
    exit 1
  else
    cat extensions.txt | xargs -L 1 code --install-extension --force
fi
