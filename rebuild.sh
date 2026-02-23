#!/bin/bash
REPO_PATH="/home/heuzef/GIT/nixos-config"

cd "$REPO_PATH" || exit
git add --all

if [[ "$1" == "fast" || "$1" == "f" ]]; then
    echo "Rebuild system (FASTER)"
    sudo nixos-rebuild switch --flake "$REPO_PATH#$(hostname)"

else
    echo "Rebuild system ..."
    nix flake update
    sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +5
    nix-collect-garbage --delete-older-than 15d
    sudo nixos-rebuild switch --flake "$REPO_PATH#$(hostname)"
fi

nixos-rebuild list-generations