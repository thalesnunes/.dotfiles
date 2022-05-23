#!/usr/bin/env bash

case "$ROFI_RETV" in
    0)  # Initial execution
        echo "Shutdown"
        echo "Suspend"
        echo "Reboot"
        echo "Logout"
        ;;
    1)  # Selected entry with Enter
        OPTION="$@"
        case $OPTION in
        Shutdown)
            systemctl poweroff
            ;;
        Suspend)
            systemctl suspend
            ;;
        Reboot)
            systemctl reboot
            ;;
        Logout)
            i3-msg exit
            ;;
        esac
esac
