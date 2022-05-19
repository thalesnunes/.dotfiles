#!/usr/bin/env bash

history_file="$HOME/.cache/mpv/playlist_history"

if [ -f $history_file ]; then
    mkdir -p "$(dirname "$dir")"
    touch $history_file
fi

if [ ! -z "$@" ]; then
    # Handle argument.
    if [ -n "$@" ]; then
        while read line; do
            if [[ $line == "$@"* ]]; then
                playlist_dir="$(echo $line | sed 's/.*=//')"
                if [[ $playlist_dir == "/run/media/thales/External HD"* ]]; then
                    udisksctl mount --object-path block_devices/sdb2 &> /dev/null
                fi
                coproc mpv -- "$playlist_dir" &> /dev/null
            fi
        done < "$history_file"
    fi
else
    sed 's/=.*//' "$history_file"
fi
