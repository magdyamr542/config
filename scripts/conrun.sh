#!/bin/bash

# this script is used to make the process of execing a command to a running container faster
# it takes a pattern of the running container's name  as its first argument 
# it takes the command to exec as its second argument

 
usage=$'Usage: ./script [container name pattern] [command]
Example: ./script runner sh
This will see if a running container has the word "runner" in it. if it does it will exec the command "sh"'

# help
if [[ "$1" == "-h" ]]; then
    echo "$usage"
    exit 0
fi

# invalid syntax
if [[ -z "$1"  || -z "$2" ]]; then
    echo "No 'container name pattern' or 'command' was specified"
    echo "$usage"
    exit 1
fi

pattern=$1
command=$2
data=$(docker ps --format '{{.Names}} {{.ID}}')
id=$(echo "$data" | grep $pattern | awk '{print $2}')

# no container has this pattern
if [[ -z "$id" ]]; then
    echo "No running container has the pattern '$pattern' in its name"
    echo "Currently running containers are:" 
    echo "$data"
    exit 1
fi

# the pattern has matched more than one container
if [[ $(grep -c . <<<"$id") > 1 ]]; then
    echo "The pattern $pattern has matched more than one container"
    echo "Currently running containers are:" 
    echo "$data"
    exit 1
fi

# exec the command 
docker exec -it "$id" "$command"
