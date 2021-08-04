#!/bin/bash

for dir in /home/thales/.config/gcalcli/*/; do
    /usr/bin/gcalcli --config-folder $dir remind --use-reminders 10 "notify-send -u normal -i appointment-soon -a Calendar %s";
done
