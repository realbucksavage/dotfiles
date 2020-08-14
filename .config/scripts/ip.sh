#!/bin/sh

ip=$(wget ifconfig.me -O - -q ; echo)
if [ "$ip" = "" ]; then
	echo ""
else
	echo "    IP: $ip   "
fi
