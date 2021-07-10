#!/bin/bash

if [ ! -z "$@" ]
then
    # Handle argument.
    if [ -n "$@" ]
    then
        source="$@";
        inputs="$(pactl list sink-inputs short | cut -f 1)";

        for input in $inputs; do
            pactl move-sink-input "$input" "$source";
        done

        pactl set-default-sink "$source";
    fi
else
    echo "$(pactl list short sinks | cut -f 2)"
fi

