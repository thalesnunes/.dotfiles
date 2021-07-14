#!/usr/bin/env bash


if [ ! -z "$@" ]
then
    # Handle argument.
    if [ -n "$@" ]
    then
        OPTION="$@"
        case $OPTION in
        Shutdown)
        systemctl poweroff
        ;;

        Reboot)
        systemctl reboot
        ;;

        Logout)
        i3-msg exit
        ;;

        Suspend)
        systemctl suspend
        ;;

        esac
    fi
else
    echo "Shutdown"
    echo "Reboot"
    echo "Logout"
    echo "Suspend"
fi
