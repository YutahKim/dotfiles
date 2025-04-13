#!/bin/bash

# Get the active window's address
WIN_ADDR=$(hyprctl activewindow -j | jq -r '.address')

# Get the window's current state
IS_FLOATING=$(hyprctl clients -j | jq -r ".[] | select(.address == \"$WIN_ADDR\") | .floating")

if [ "$IS_FLOATING" = "false" ]; then
    # Save position and size
    WIN_INFO=$(hyprctl clients -j | jq -r ".[] | select(.address == \"$WIN_ADDR\")")
    X=$(echo "$WIN_INFO" | jq -r '.at[0]')
    Y=$(echo "$WIN_INFO" | jq -r '.at[1]')
    WIDTH=$(echo "$WIN_INFO" | jq -r '.size[0]')
    HEIGHT=$(echo "$WIN_INFO" | jq -r '.size[1]')

    # Toggle to floating
    hyprctl dispatch togglefloating

    # Restore position and size
    hyprctl dispatch moveactive exact "$X" "$Y"
    hyprctl dispatch resizeactive exact "$WIDTH" "$HEIGHT"
else
    # Toggle back to tiling
    hyprctl dispatch togglefloating
fi

