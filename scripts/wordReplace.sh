#!/bin/bash

# Check if two arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <old_word> <new_word>"
    exit 1
fi

# Assign arguments to variables
foo="$1"
bar="$2"

find . -type f -exec sed -i "s/${foo}/${bar}/g" {} +
