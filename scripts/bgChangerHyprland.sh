#!/bin/bash

# Directory containing your wallpapers
WALLPAPER_DIR="$HOME/Pictures/bg"

# Get all connected monitors
MONITORS=$(hyprctl monitors | grep 'Monitor' | awk '{print $2}')

while true; do
    # Declare an array to store selected wallpapers
    declare -a USED_WALLPAPERS=()

    for MONITOR in $MONITORS; do
        # Pick a random wallpaper that hasn’t been used yet
        while true; do
            WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -iname '*.jpg' -o -iname '*.png' -o -iname '*.jpeg' \) | shuf -n 1)
            [[ ! " ${USED_WALLPAPERS[*]} " =~ " ${WALLPAPER} " ]] && break
        done

        # Add it to the used list
        USED_WALLPAPERS+=("$WALLPAPER")

        # Preload and assign the wallpaper to this monitor
        hyprctl hyprpaper preload "$WALLPAPER"
        hyprctl hyprpaper wallpaper "$MONITOR,$WALLPAPER"
    done

    # Wait before refreshing again
    sleep 60
done

