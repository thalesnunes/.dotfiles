#!/bin/bash

if ! pgrep -x "WhatsappWeb" > /dev/null
then
    rm -rf "/home/thales/.config/whatsappweb-nativefier-d40211/Service Worker/Database/"
fi

/home/thales/Apps/WhatsappWeb-linux-x64/WhatsappWeb
