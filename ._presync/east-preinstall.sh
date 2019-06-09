#!/bin/bash

echo "RealBuckSavage EAST pre-sync Hook"

mkdir -p ~/tools

echo "Installing yay..."

git clone https://aur.archlinux.org/yay.git ~/tools/yay
cd ~/tools/yay
makepkg -si

echo "Installing suckless programs..."

git clone https://git.suckless.org/st ~/tools/st
git clone https://git.suckless.org/dmenu ~/tools/dmenu

cd ~/tools/st
sudo make install

cd ~/tools/dmenu
sudo make install

echo "Installing fonts"
yay -S ttf-emojione ttf-hack ttf-inconsolata ttf-roboto ttf-roboto-mono ttf-symbola

echo "Installing snap"
yay -S snapd

echo "Enabling services (if needed)..."
sudo systemctl enable --now snapd.service
