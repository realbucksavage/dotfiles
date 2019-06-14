#!/bin/bash

if [[ "$PACKAGECTL" == "xbps" ]]; then
  echo "Running voidlinux. Installing build tools first."

  xbps-install -Sfy fontconfig-devel libX11-devel libXft-devel ncurses st-terminfo make pkg-config gcc libXinerama-devel
fi

echo "Installing Suckless programs... (https://suckless.org)"

$deu git clone https://git.suckless.org/st $home/tools/st
$deu git clone https://git.suckless.org/dmenu $home/tools/dmenu

cd $home/tools/st
make install

cd $home/tools/dmenu
make install

echo "Installing vim symlink"
mv /usr/bin/vim /usr/bin/vim.org
ln -s /usr/bin/nvim /usr/bin/vim

if [[ "$PACKAGECTL" == "pacman" ]]; then
  systemctl enable lightdm
  ln -s /etc/sv/dbus /var/service/dbus
fi

if [[ "$PACKAGECTL" == "xbps" ]]; then
  ln -s /etc/sv/lightdm /var/service/
fi
