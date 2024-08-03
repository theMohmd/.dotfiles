#!/bin/bash

# Get the current active window's app ID
app_id=$(hyprctl activewindow | grep "class:" | awk '{print $2}')

# Get the current active window's title
app_name=$(hyprctl activewindow | grep "title:" | cut -d' ' -f2-)

# Output the app name or ID
if [ -z "$app_name" ]; then
    echo "$app_id"
else
    echo "$app_name"
fi
