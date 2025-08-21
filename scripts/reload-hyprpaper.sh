#!/usr/bin/env bash

if [ "$1" == "-w" ]; then
  echo Waiting fot hyprpaper to start
  until pids=$(pidof hyprpaper)
  do
    sleep 1
  done

  sleep 1
fi

WALLPAPER_DIR="$HOME/wallpapers/desktop"
CURRENT_WALL=$(hyprctl hyprpaper listloaded)

# Get a random wallpaper that is not the current one
WALLPAPER=$(find "$WALLPAPER_DIR" -type f ! -name "$(basename "$CURRENT_WALL")" | shuf -n 1)

# Apply the selected wallpaper
hyprctl hyprpaper reload ,"$WALLPAPER"
