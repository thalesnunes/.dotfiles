#!/bin/bash

export XDG_RUNTIME_DIR=/run/user/$(id -u)

for dir in /home/thales/.config/gcalcli/*/; do
    /usr/bin/gcalcli --config-folder $dir remind 5 "notify-send -u critical -i appointment-soon -a Calendar %s";
done
