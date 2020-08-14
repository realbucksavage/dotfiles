#!/bin/sh

status=$(xinput list-props 12 | grep "Device Enabled" | tail -c 2 | head -c 1)

if [ "$status" = 1 ]; then
	xinput disable 12
else
	xinput enable 12
fi
