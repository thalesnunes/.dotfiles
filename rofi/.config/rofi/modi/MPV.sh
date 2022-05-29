#!/usr/bin/env bash

history_file="$HOME/.cache/mpv/playlist_history"

if [ -f $history_file ]; then
    mkdir -p "$(dirname "$dir")"
    touch $history_file
fi

case "$ROFI_RETV" in
    0)  # Initial execution
        echo -en "\0use-hot-keys\x1ftrue\n"
        sed 's/=.*//' "$history_file" | sort
        ;;
    1)  # Selected entry with Enter
        while read line; do
            if [[ $line == "$@"* ]]; then
                playlist_dir="$(echo $line | sed 's/.*=//')"
                if [[ $playlist_dir == "/run/media/thales/External HD"* ]]; then
                    udisksctl mount --object-path block_devices/sdb2 &> /dev/null
                fi
                coproc mpv -- "$playlist_dir" &> /dev/null
            fi
        done < "$history_file"
        ;;
    10) # Deleted entry with Control+d
        sed -i "/$1=.*/d" "$history_file"
        sed 's/=.*//' "$history_file" | sort
        ;;
esac
