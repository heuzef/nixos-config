#!/usr/bin/env bash
# Rebuild the NixOS system from this flake.

set -euo pipefail

REPO_PATH="/home/heuzef/GIT/nixos-config"

usage() {
    cat <<USAGE
Usage: $(basename "$0") [fast]

  (no argument)  Clean the store, update the flake inputs, then rebuild.
  fast, --fast   Rebuild only, without cleaning nor updating the inputs.
                 Short forms: f, -f
USAGE
}

# Parse arguments first, so a typo fails before anything is touched
FAST=false
case "${1:-}" in
    "")               ;;
    fast|f|--fast|-f) FAST=true ;;
    -h|--help)        usage; exit 0 ;;
    *)
        echo "Error: unknown argument '$1'." >&2
        usage >&2
        exit 1
        ;;
esac

cd "$REPO_PATH"

# Ask for the sudo password up front. Without a terminal sudo cannot prompt,
# and the privileged steps would be skipped silently.
if ! sudo -v; then
    echo "Error: sudo authentication failed. Run this script from a terminal." >&2
    exit 1
fi

# Stage everything: flake evaluation ignores files untracked by git
git add --all

if [[ "$FAST" == true ]]; then
    echo "Quickly rebuild system ..."
else
    echo "Cleaning system ..."
    sudo journalctl --vacuum-size=100M
    nix-collect-garbage --delete-older-than 7d
    nix-store --gc
    sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +3
    echo "Update system ..."
    nix flake update
    echo "Rebuild system ..."
fi

sudo nixos-rebuild switch --flake "$REPO_PATH#$(hostname)"

nixos-rebuild list-generations
