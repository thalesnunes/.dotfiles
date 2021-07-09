#!/usr/bin/env bash

ROFI="${HOME}/.config/rofi"

if [ ! -z "$@" ]
then
    # Handle argument.
    if [ -n "$@" ]
    then
        coproc ( ${ROFI}/bin/launcher_colorful "$@" & > /dev/null 2>&1 )
    fi
else
    echo "$(ls -1 --hide Mixed.sh "${ROFI}/modi" | sed -e 's/\..*$//')"
fi
