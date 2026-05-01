#!/bin/bash
APPIMAGES_URLS=(
    "https://github.com/cjpais/Handy/releases/download/v0.8.2/Handy_0.8.2_amd64.AppImage" # https://handy.computer
    "https://api.hayase.watch/files/linux-hayase-6.4.60-linux.AppImage" # https://hayase.watch/download
    "https://github.com/DantSu/Telmi-Sync/releases/download/0.17.0/Telmi.Sync-0.17.0.AppImage" # https://telmi.fr/#download
)

cd appimages/
mkdir -p ~/.local/share/applications/
rm -vf ./*.AppImage

for url in "${APPIMAGES_URLS[@]}"; do
    echo "Download : $url"
    wget -c -P "./" "$url"
done

sudo chmod +x -R .
cp -v ./*.desktop ~/.local/share/applications/

# Todo : improve this script with lastversion
# Eg : lastversion https://github.com/DantSu/telmi-sync ; lastversion https://github.com/cjpais/Handy
# https://lastversion.getpagespeed.com/
