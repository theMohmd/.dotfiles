#!/bin/bash

# multi rename

function mrn() {
  local old new
  if [ "$#" -ne 2 ]; then
    read -p "old word: " old
    read -p "new word: " new
  else
    old="$1"
    new="$2"
  fi

  cp -r "$PWD" "$PWD.bak"

  find . -depth \( -name "*$old*" -o -name "*${old^}*" \) | while read path; do
  base=$(basename "$path")
  dir=$(dirname "$path")
  newname="$base"
  [[ "$base" == *"$old"* ]] && newname="${newname//$old/$new}"
  [[ "$base" == *"${old^}"* ]] && newname="${newname//${old^}/${new^}}"
  mv "$path" "$dir/$newname"
done
}
