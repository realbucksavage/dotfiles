#!/bin/sh

workspacenames=("" "1: ⌘ " "2: ⌘ " "3: 龜" "4:  " "5:  " "6: ⌘ " "7: ⌘ " "8: ⌘ " "9: ⌘ " "10: ⌘ ")

activeworkspaces=("" $(for i in {4..121..13}
do
	echo "$(i3-msg -t get_workspaces | cut -d\: -f$i | cut -d\" -f2)"
done ))

for i in {1..10..1}
do
	if [ "$i" != "${activeworkspaces[i]}" ]; then
		i3-msg move container to workspace "${workspacenames[i]}"
		break
	fi 
done
