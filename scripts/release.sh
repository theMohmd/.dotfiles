git switch develop

release-master() {
  if [ -z "$1" ]; then
    echo "Usage: gitflow-release <version>"
    return 1
  fi

  local version="v$1"
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
}

# Define a function to handle the menu selection
function handle_menu_selection() {
    local choice="$1"
    case "$choice" in
        1) hlp ;;
        2) mrn ;;
        3) mrp ;;
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
