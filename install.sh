#!/bin/bash

if [ "$EUID" -eq 0 ]; then
    echo "Please avoid running this script as root."
    exit 1
fi

echo "Running as user: $USER."
read -p "Perform installation? " -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 # handle exits from shell or function but don't exit interactive shell
fi
echo "======================================="

EAST_DIR=$(dirname "$BASH_SOURCE")

declare -a packages=( "wget"  "vim"  "xorg-server"  "xorg-server-common"  "xorg-xinit"  "xcompmgr"  "python-pip"  "lightdm"  "lightdm-gtk-greeter"  "lightdm-gtk-greeter-settings"  "pulseaudio"  "pulsemixer"  "i3-gaps"  "i3blocks"  "openssh"  "cronie"  "bash-completion"  "neomutt"  "nitrogen"  "linux-headers" )

echo "Performing a system udpate."
sudo pacman -Syyu

echo "Executing pre-sync scripts (if any)..."
cd $EAST_DIR/._presync
for f in *.sh; do
  bash "$f" -H || break  # execute successfully or break
  # Or more explicitly: if this execution fails, then stop the `for`:
  # if ! bash "$f" -H; then break; fi
done

echo "Installing packages..."
sudo pacman -Sy ${packages[@]}

echo "Executing post-sync scripts (if any)..."
cd $EAST_DIR/._postsync
for f in *.sh; do
  bash "$f" -H || break  # execute successfully or break
  # Or more explicitly: if this execution fails, then stop the `for`:
  # if ! bash "$f" -H; then break; fi
done

echo "Copying user configuration"
cp -r $EAST_DIR/._home/ $HOME/