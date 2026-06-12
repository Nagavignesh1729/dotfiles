#!/bin/sh
# Switch to another wallpaper with a smooth transition growing from the cursor.
DIR="$HOME/Pictures/wallpapers"
cur="$(awww query 2>/dev/null | grep -oE '/[^ ]+\.(jpg|jpeg|png)' | head -1)"
next="$(find "$DIR" -type f \( -iname '*.jpg' -o -iname '*.png' -o -iname '*.jpeg' \) | grep -vF "$cur" | shuf -n1)"
[ -z "$next" ] && next="$(find "$DIR" -type f | shuf -n1)"
pos="$(hyprctl cursorpos 2>/dev/null | tr -d ' ')"
awww img "$next" --transition-type grow ${pos:+--transition-pos "$pos"} --transition-fps 60 --transition-duration 1.2
