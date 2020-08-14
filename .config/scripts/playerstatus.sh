#!/bin/sh
taken="$(/home/rensenware/.config/scripts/wkspacecounter.sh)"
maxlen="$(expr 105 - "$taken")"
if [ "$maxlen" -gt "70" ]; then
	maxlen=70
fi
maxlentrunc="$(expr "$maxlen" - 4)"

set -e
playerctl -p spotify status 2> /dev/null > /dev/null

data="$(echo "$(playerctl -p spotify metadata title)"" by ""$(playerctl -p spotify metadata artist)")"

if [ "$(echo "$data" | wc -c)" -gt "$maxlen" ]; then
	data="$(echo "$(echo "$data" | head -c "$maxlentrunc")"" . .")"
fi

if [ "$(playerctl -p spotify status)" = "Paused" ]; then
	echo "  $data"
else
	echo "  $data"
fi
