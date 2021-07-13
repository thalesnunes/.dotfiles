#!/bin/bash

DIR="${HOME}/.dotfiles/polybar/.config/polybar/"
result=$(cat ~/.sun)
IFS=" " read -r sunrise sunset <<< "$result"

now=$(date +%H:%M)

if [[ "$now" > "$sunrise" ]] && [[ "$now" < "$sunset" ]]; then
    COLORS=colors.day
else
    COLORS=colors.night
fi

cp $DIR/forest/$COLORS $DIR/forest/colors.ini
${HOME}/.config/polybar/launch.sh --forest > /dev/null 2>&1 &
