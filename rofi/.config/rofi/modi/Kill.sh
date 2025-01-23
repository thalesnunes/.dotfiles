#!/usr/bin/env bash

case "$ROFI_RETV" in
    0)  # Initial execution
        echo "$(ps -Ao comm,%mem --sort=-%mem | tail -n +2)"
        ;;
    1)  # Selected entry with Enter
        process_name="$(echo "$@" | cut -d' ' -f1)"
        coproc ( killall --ignore-case --signal SIGKILL --user $(whoami) "${process_name}" & > /dev/null 2>&1 )
esac
