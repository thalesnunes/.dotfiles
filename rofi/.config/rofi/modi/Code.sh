#!/usr/bin/env bash

PROJECTS="${HOME}/Projects"

if [ ! -z "$@" ]
then
    # Handle argument.
    if [ -n "$@" ]
    then
        coproc ( $EDITOR "${PROJECTS}/$@" & > /dev/null 2>&1 )
    fi
else
    echo "$(ls -1 "${PROJECTS}" | sed -e 's/\..*$//')"
fi
