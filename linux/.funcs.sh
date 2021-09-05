

# adding a file with a pattern istead of writing the full path
gad () {
  git add "*$1*"
}

gbname () {
  git branch  | grep "$1"
}


# check if command exists
doesCommandExist () {
  return $(command -v $1 &> /dev/null)
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

# history grep faster
hgrep () {
  history | grep $1
}
