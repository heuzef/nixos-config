#!/bin/sh
# Build
sh ~/GIT/nixos-config/rebuild.sh fast

# Get AppImages
sh ~/GIT/nixos-config/appimages_deploy.sh

# Sync fonts
mkdir ~/.local/share/fonts/
ln -s ~/GIT/nixos-config/fonts/* ~/.local/share/fonts/

reboot
