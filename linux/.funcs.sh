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

# capture the output of a command to the clipboard
cap () { 
  tee /tmp/capture.out;
  cat /tmp/capture.out | xsel -ib 
} 

# sourcing an env file manually with the env-reader utlity https://github.com/magdyamr542/env-reader
sourceenv() {
 sed '/^#/d;/^[[:space:]]*$/d' "$1" | while read -r line; do export "$line"; done    
}
