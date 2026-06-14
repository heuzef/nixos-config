#!/bin/bash
ln -s ~/GIT/nixos-config/fonts/* ~/.local/share/fonts/ # Sync fonts
sh ~/GIT/nixos-config/rebuild.sh fast
sh ~/GIT/nixos-config/appimages_deploy.sh
reboot
