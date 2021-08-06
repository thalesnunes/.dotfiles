#!/bin/bash

for dir in /home/thales/.config/gcalcli/*/; do
    XDG_RUNTIME_DIR=/run/user/$(id -u) /usr/bin/gcalcli --config-folder $dir remind 10 "notify-send -u critical -i appointment-soon -a Calendar %s";
done
