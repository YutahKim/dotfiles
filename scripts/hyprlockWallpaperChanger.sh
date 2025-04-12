#!/bin/bash
# Save this script as ~/scripts/random_wallpaper.sh

WALLPAPER_DIR="$HOME/Pictures/bg"
find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.webp" \) | shuf -n 1

