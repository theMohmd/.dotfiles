#!/bin/bash

# Check if two arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <old_word> <new_word>"
    exit 1
fi

find . -type f -exec sed -i "s/${1}/${2}/g" {} +
