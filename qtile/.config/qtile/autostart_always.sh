#!/usr/bin/env bash

xrandr --output VGA-0 --off --output DVI-D-0 --mode 1920x1080 --pos 1920x0 --rotate left --output HDMI-0 --primary --mode 1920x1080 --pos 0x215 --rotate normal
$HOME/Scripts/polybar_starter.sh &
$HOME/Scripts/feh_init.sh &
