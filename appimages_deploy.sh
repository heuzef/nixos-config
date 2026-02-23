#!/bin/bash
APPIMAGES_URLS=(
    "https://github.com/cjpais/Handy/releases/download/v0.6.9/Handy_0.7.6_amd64.AppImage" # https://handy.computer
    "https://api.hayase.watch/files/linux-hayase-6.4.56-linux.AppImage" # https://hayase.watch/download
    "https://github.com/DantSu/Telmi-Sync/releases/download/0.14.0/Telmi.Sync-0.15.1.AppImage" # https://telmi.fr/#download
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
