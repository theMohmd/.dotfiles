#!/bin/bash

# Check if two arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <old_word> <new_word>"
    exit 1
fi

# Assign arguments to variables
old_word="$1"
new_word="$2"

# Run the find command
find . -depth -name "*$old_word*" -execdir bash -c 'mv "$1" "${1//$2/$3}"' bash {} "$old_word" "$new_word" \;
#find . -depth -name '*foo*' -execdir bash -c 'mv "$1" "${1//foo/bar}"' bash {} \;
