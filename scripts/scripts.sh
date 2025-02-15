#!/bin/bash

function mrp() {
    local old
    local new
    if [ "$#" -ne 2 ]; then
        read -p "old word: " old
        read -p "new word: " new
    else
        old="$1"
        new="$2"
    fi

    #backup
    cp -r $PWD $PWD.bak
    find . -type f -exec sed -i "s/${old}/${new}/g" {} +
}
function mrn() {
    local old
    local new
    if [ "$#" -ne 2 ]; then
        read -p "old word: " old
        read -p "new word: " new
    else
        old="$1"
        new="$2"
    fi

    #backup
    cp -r $PWD $PWD.bak
    find . -depth -name "*$old*" -execdir bash -c 'mv "$1" "${1//$2/$3}"' bash {} "$old" "$new" \;
}

release() {
  read -p "Enter your version(0.0.0): " inputVersion
  local version="v$inputVersion"
  git switch master
  git pull
  git switch develop
  git pull
  git flow release start "$version" && git flow release finish "$version" -m "update"
}

rp() {
  git push && git checkout master && git push && git checkout develop && git push --tags
}
# Define a function to display the menu
function display_menu() {
    echo "Select a function:"
    echo "1. mutifile name replace(mrn)"
    echo "2. multifile word replace(mrp)"
    echo "3. git flow (release)"
    echo "4. git flow release push(rp)"
}

# Define a function to handle the menu selection
function handle_menu_selection() {
    local choice="$1"
    case "$choice" in
        1) mrn ;;
        2) mrp ;;
        3) release ;;
        4) rp ;;
        *) echo "Invalid selection" ;;
    esac
}

# main
# Check if the first argument exists
if [ -n "$1" ]; then
    # If the first argument exists, run the function specified in the argument
    function="$1"
    shift
    "$function" "$@"
else
    # If no first argument, display the menu and handle the selection
    display_menu
    read -p "Enter your choice: " choice
    handle_menu_selection "$choice"
fi
