#!/bin/sh

micvol=$(pamixer --source 1 --get-volume)

if [ "$(pamixer --source 1 --get-mute)" = "true" ]; then
	echo "  00%"
elif [ "$micvol" = "0" ]; then
	echo "  00%"
elif [ "10" -gt "$micvol" ]; then
	echo "  0$micvol%"
else
	echo "  $micvol%"
fi
