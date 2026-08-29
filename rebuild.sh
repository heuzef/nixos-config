#!/bin/bash
REPO_PATH="/home/heuzef/GIT/nixos-config"

cd "$REPO_PATH" || exit
git add --all

if [[ "$1" == "fast" || "$1" == "f" ]]; then
    echo "Quickly rebuild system ..."
    sudo nixos-rebuild switch --flake "$REPO_PATH#$(hostname)"

else
    echo "Cleaning system ..."
    sudo journalctl --vacuum-size=100M
    nix-collect-garbage --delete-older-than 7d
    nix-store --gc
    sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +3
    echo "Update system ..."
    nix flake update
    echo "Rebuild system ..."
    sudo nixos-rebuild switch --flake "$REPO_PATH#$(hostname)"
fi

nixos-rebuild list-generations
