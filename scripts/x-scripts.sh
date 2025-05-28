#!/bin/bash

source ~/.dotfiles/scripts/x-scripts/avif.sh
source ~/.dotfiles/scripts/x-scripts/mrp.sh
source ~/.dotfiles/scripts/x-scripts/mrn.sh
source ~/.dotfiles/scripts/x-scripts/fr.sh
source ~/.dotfiles/scripts/x-scripts/release.sh
source ~/.dotfiles/scripts/x-scripts/nct.sh

# Define a function to display the menu
function display_menu() {
  echo "Select a function:"
  echo "1. mutifile file rename(mrn)"
  echo "2. multifile word replace(mrp)"
  echo "3. full replace(fr)"
  echo "4. git flow (release)"
  echo "5. git flow release push(rp)"
  echo "6. next component tree(nct)"
  echo "7. avif"
}

# Define a function to handle the menu selection
function handle_menu_selection() {
  local choice="$1"
  case "$choice" in
    1) mrn ;;
    2) mrp ;;
    3) fr ;;
    4) release ;;
    5) rp ;;
    6) nct ;;
    7) avif ;;
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
