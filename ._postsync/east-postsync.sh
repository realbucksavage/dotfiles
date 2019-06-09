#!/bin/bash

echo "Running post-installation scripts"

echo "Installing pipenv"
sudo pip3 install pipenv

echo "Downloading EAST Config from GH"
mkdir -p ~/.east
cd ~/.east

wget "https://gist.githubusercontent.com/jgodara/e2d8af2a858e5fe983bbb1496efea921/raw/fb4230b753bd0f96c0864d6db88aecfc0753d415/eastfile.yaml"
wget "https://gist.githubusercontent.com/jgodara/7e26799a295d43c0a785804bf4eb8bcc/raw/b9e3e17da802b5d375d43e8368f2ac99b2c4df89/east-presync.sh"
wget "https://gist.githubusercontent.com/jgodara/9829fff448332dc0658ae3d924cb760e/raw/d39677b29e6b7a8c0d1a23b13686640bd47116fa/east-postsync.sh"

chmod +x *.sh

echo "Enabling lightdm"
sudo systemctl enable lightdm.service

echo "All done. Please reboot after EAST completes."
