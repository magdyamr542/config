

# adding a file with a pattern istead of writing the full path
gad () {
  git add "*$1*"
}

gbname () {
  git branch  | grep "$1"
}

