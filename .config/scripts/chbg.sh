#!/bin/sh

case "$(echo "$1" | head -c 8)" in
	"Pictures")
		WALLPAPER="/home/rensenware/Pictures/Wallpapers/""$(echo "$1" | cut -d\/ -f3)"
		if [ -f "$WALLPAPER" ]; then
			echo "$WALLPAPER" > /home/rensenware/.config/scripts/currentwallpaper
			feh --bg-scale --no-fehbg "$WALLPAPER"
		else
			echo "Not a valid file path!"
		fi ;;
	"Wallpape")
		WALLPAPER="/home/rensenware/Pictures/Wallpapers/""$(echo "$1" | cut -d\/ -f2)"
		if [ -f "$WALLPAPER" ]; then
			echo "$WALLPAPER" > /home/rensenware/.config/scripts/currentwallpaper
			feh --bg-scale --no-fehbg "$WALLPAPER"
		else
			echo "Not a valid file path!"
		fi ;;
	"/home/re")
		if [ -f "$1" ]; then
			echo "$1" > /home/rensenware/.config/scripts/currentwallpaper
			feh --bg-scale --no-fehbg "$1"
		else
			echo "Not a valid file path!"
		fi ;;
	*)
		WALLPAPER="/home/rensenware/Pictures/Wallpapers/$1"
		if [ -f "$WALLPAPER" ]; then
			echo "$WALLPAPER" > /home/rensenware/.config/scripts/currentwallpaper
			feh --bg-scale --no-fehbg "$WALLPAPER"
		else
			echo "Not a valid file path!"
		fi ;;
esac
