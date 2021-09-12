#!/usr/bin/env bash

PROJECTS="$HOME/Projects"

if [ ! -z "$@" ]
then
    # Handle argument.
    if [ -n "$@" ]
    then
        terminal -cd "$PROJECTS/$@" -e nvim
    fi
else
    echo "$(ls -1 "$PROJECTS" | sed -e 's/\..*$//')"
fi
