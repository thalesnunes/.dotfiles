#!/usr/bin/env bash

PROJECTS="$HOME/Projects"

if [ ! -z "$@" ]
then
    # Handle argument.
    if [ -n "$@" ]
    then
        terminal -e "cd \"$PROJECTS/$@\" && $EDITOR"
    fi
else
    echo "$(ls -1 "$PROJECTS" | sed -e 's/\..*$//')"
fi
