#!/usr/bin/env bash

case "$ROFI_RETV" in
    0)  # Initial execution
        echo -en "\0use-hot-keys\x1ftrue\n"
        cliphist list | sort -n -r | awk -F' ' '{$1=""; print substr($0, 2)}'
        ;;
    1)  # Selected entry with Enter
        while read line; do
            if [[ $line == *"$@" ]]; then
                coproc ( echo "$line" | cliphist decode | wl-copy &> /dev/null )
            fi
        done < <(cliphist list)
        ;;
    10) # Deleted entry with Control+d
        while read line; do
            if [[ $line == *"$@" ]]; then
                coproc ( echo "$line" | cliphist delete &> /dev/null )
            fi
        done < <(cliphist list)
        cliphist list | sort -n -r | awk -F' ' '{$1=""; print substr($0, 2)}'
        ;;
esac
