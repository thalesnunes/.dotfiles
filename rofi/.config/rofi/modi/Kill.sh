#!/usr/bin/env bash

if [ ! -z "$@" ]
then
    # Handle argument.
    if [ -n "$@" ]
    then
        process_name="$(echo "$@" | cut -d' ' -f1)"
        coproc ( killall --ignore-case --user $(whoami) "${process_name}" & > /dev/null 2>&1 )
    fi
else
    echo "$(ps -Ao comm,%mem --sort=-%mem | tail -n +2)"
fi
