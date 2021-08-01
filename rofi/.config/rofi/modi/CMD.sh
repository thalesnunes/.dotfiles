#!/usr/bin/env bash

if [ ! -z "$@" ]
then
    # Handle argument.
    if [ -n "$@" ]
    then
        coproc ( terminal -hold -e "$@" )
    fi
fi
