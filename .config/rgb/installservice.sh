#!/bin/bash

SYSTEMD_SERVICE="/etc/systemd/system/openrgb.service"
sudo cp ./openrgb.service $SYSTEMD_SERVICE
sudo chmod 644 $SYSTEMD_SERVICE

sudo systemctl enable --now openrgb.service

if [ "0" == "$?" ]; then
    echo "Service installed..."
    systemctl status openrgb
fi
