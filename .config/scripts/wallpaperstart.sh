#!/bin/sh

x=$(echo "$(cat /home/rensenware/.config/scripts/currentwallpaper)")
feh --bg-scale --no-fehbg "$x"
