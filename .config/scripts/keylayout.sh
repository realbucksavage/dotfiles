#!/bin/sh

x=$(setxkbmap -query | grep layout | tail -c 3 | head -c 2)
y="ak"

if [ "$x" = "$y" ]; then
	setxkbmap us -option compose:ralt
else
	setxkbmap dvorak -option compose:ralt
fi
