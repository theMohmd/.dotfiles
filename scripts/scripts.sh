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
function hlp ()
{
   echo ""
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
  git switch develop
  git flow release start "$version" && git flow release finish "$version" -m "update"
}

release-push() {
  git push && git checkout master && git push && git checkout develop && git push --tags
}
# Define a function to display the menu
function display_menu() {
    echo "Select a function:"
    echo "1. help"
    echo "2. mutifile name replace(mrn)"
    echo "3. multifile word replace(mrp)"
    echo "4. git flow release"
    echo "5. git flow release push"
}

# Define a function to handle the menu selection
function handle_menu_selection() {
    local choice="$1"
    case "$choice" in
        1) hlp ;;
        2) mrn ;;
        3) mrp ;;
        4) release ;;
        5) release-push ;;
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
