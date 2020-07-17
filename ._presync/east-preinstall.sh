#!/bin/bash

if [[ "$PACKAGECTL" == "pacman" ]]; then

  echo "RealBuckSavage EAST pre-sync Hook (Arch/Manjaro)"

  sed -i 's/\#Color/Color/g' /etc/pacman.conf

  $deu mkdir -p $home/tools

  echo "Installing yay..."

  $deu git clone https://aur.archlinux.org/yay.git $home/tools/yay
  cd $home/tools/yay
  $deu makepkg -si

  echo "Installing fonts"
  $deu yay -S ttf-emojione ttf-hack ttf-inconsolata ttf-roboto ttf-roboto-mono ttf-symbola

  echo "Installing zsh plugins"
  $deu sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  $deu yay -S zsh-syntax-highlighting
fi
