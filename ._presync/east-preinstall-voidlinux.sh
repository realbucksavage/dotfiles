#!/bin/bash

if [[ "$PACKAGECTL" == "xbps" ]]; then

  echo "RealBuckSavage EAST pre-sync Hook (Voidlinux)"

  echo "Changing mirror"
  mkdir -p /etc/xbps
  cp /usr/share/xbps.d/*-repository-*.conf /etc/xbps.d/
  sed -i 's|https://alpha.de.repo.voidlinux.org|https://void.webconverger.org|g' /etc/xbps.d/*-repository-*.conf

  mkdir -p ~/tools

  echo "Installing fonts"
  xbps-install -Sfy fonts-roboto-ttf font-inconsolata-otf font-hack-ttf font-symbola
fi
