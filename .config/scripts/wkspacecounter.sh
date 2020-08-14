#!/bin/sh

j=0
for i in {4..121..13}
do
	case "$(i3-msg -t get_workspaces | cut -d\: -f$i | cut -d\" -f2)" in
		"1"|"2"|"3"|"4"|"5"|"6"|"7"|"8"|"9"|"10")
		j="$(($j + 1))"
	esac
done
j="$(($j * 8))"
j="$((j - 1))"

echo "$j"
