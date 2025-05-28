#!/bin/bash

source ~/.dotfiles/scripts/x-scripts/mrp.sh
source ~/.dotfiles/scripts/x-scripts/mrn.sh

# full replace ( mrn and mrp )

function fr() {
  local old new
  if [ "$#" -ne 2 ]; then
    read -p "old word: " old
    read -p "new word: " new
  else
    old="$1"
    new="$2"
  fi

  cp -r "$PWD" "$PWD.bak"
  mrp "$old" "$new"
  mrn "$old" "$new"
}
