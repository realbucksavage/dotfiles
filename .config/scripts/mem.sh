#!/bin/sh

mb="$(free -m | tail -n 2 | head -n 1 | head -c 31 | tail -c 4 | cut -d\  -f2)"
gb=$(bc <<< $(echo "scale=2; $mb/1024"))
isgreater=$(bc <<< $(echo "$gb > 1"))

if [ "$isgreater" = 1 ]; then
	echo "   RAM: $gb GB    "
else
	echo "   RAM: 0$gb GB    "
fi
