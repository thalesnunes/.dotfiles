#!/bin/bash

DIR="/home/thales/Imagens/Wallpapers"
day="79_nologo.jpg"
night="HD KDE Plasma Abstract 345 NO LOGO.png"

result=$(cat ~/.sun)
IFS=" " read -r sunrise sunset <<< "$result"

now=$(date +%H:%M)

if [[ "$now" > "$sunrise" ]] && [[ "$now" < "$sunset" ]]; then
    Wallpaper=$day
else
    Wallpaper=$night
fi

feh --no-fehbg --bg-scale "$DIR/$Wallpaper"

