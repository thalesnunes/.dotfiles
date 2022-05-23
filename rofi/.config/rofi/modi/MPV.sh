#!/usr/bin/env bash

history_file="$HOME/.cache/mpv/playlist_history"

if [ -f $history_file ]; then
    mkdir -p "$(dirname "$dir")"
    touch $history_file
fi

if [ ! -z "$@" ]; then
    # Handle argument.
    if [ -n "$@" ]; then
        case "$ROFI_RETV" in
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
            10)
                sed -i "/$1=.*/d" "$history_file"
                sed 's/=.*//' "$history_file" | sort
                ;;
        esac
    fi
else
    echo -en "\0use-hot-keys\x1ftrue\n"
    sed 's/=.*//' "$history_file" | sort
fi
