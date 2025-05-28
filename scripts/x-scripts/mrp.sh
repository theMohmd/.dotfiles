#!/bin/bash

# multi replace ( replaces a word with new one in a directory )

function mrp() {
  local old new
  if [ "$#" -ne 2 ]; then
    read -p "old word: " old
    read -p "new word: " new
  else
    old="$1"
    new="$2"
  fi

  cp -r "$PWD" "$PWD.bak"

  find . -type f -exec sed -i "s/$old/$new/g" {} +

  capitalized_old=$(echo "$old" | sed 's/^\(.\)/\U\1/')
  capitalized_new=$(echo "$new" | sed 's/^\(.\)/\U\1/')

  find . -type f -exec sed -i "s/$capitalized_old/$capitalized_new/g" {} +
}
