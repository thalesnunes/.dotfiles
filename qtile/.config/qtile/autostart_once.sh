#!/usr/bin/env bash

picom -b &
$HOME/Scripts/sunrise-sunset.sh &
urxvtd -q -o -f
redshift -l -23.536215622740578:-46.68497829306198 &
setxkbmap -option "caps:swapescape"
# systemctl --user restart dunst.service &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
keynav daemonize
clipit --no-icon &
xautolock -time 20 -locker blurlock &
/usr/lib/kdeconnectd &
xset b off s off -dpms
