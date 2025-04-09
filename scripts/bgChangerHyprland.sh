#!/bin/bash

# Directory containing your wallpapers
WALLPAPER_DIR="$HOME/Pictures/bg"

# Get the name of your monitor
MONITOR=$(hyprctl monitors | grep 'Monitor' | awk '{print $2}')

# Infinite loop to change wallpaper every minute
while true; do
    # Select a random image from the directory
    WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -iname '*.jpg' -o -iname '*.png' -o -iname '*.jpeg' \) | shuf -n 1)

    # Preload and set the wallpaper using Hyprpaper
    hyprctl hyprpaper preload "$WALLPAPER"
    hyprctl hyprpaper wallpaper "$MONITOR,$WALLPAPER"

    # Wait for 60 seconds before changing the wallpaper again
    sleep 60
done

