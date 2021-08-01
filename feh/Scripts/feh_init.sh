#!/bin/bash

DIR="/home/thales/Imagens/Wallpapers"
day="cropped-1920-1080-679478.jpg"
night="cropped-1920-1080-959309.png"

result=$(cat ~/.sun)
IFS=" " read -r sunrise sunset <<< "$result"

now=$(date +%H:%M)

if [[ "$now" > "$sunrise" ]] && [[ "$now" < "$sunset" ]]; then
    Wallpaper=$day
else
    Wallpaper=$night
fi

feh --no-fehbg --bg-fill "$DIR/$Wallpaper"
