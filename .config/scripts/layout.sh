#!/bin/sh

key=$(setxkbmap -query | grep layout | tail -c 3 | head -c 2)
dv="ak"
us="us"

if [ "$key" = "$dv" ]; then
	echo "dv"
else
	echo "us"
fi
