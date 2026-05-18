#!/bin/bash
# Requirements : wget, lastversion
# Configuration
APPIMAGE_DIR="appimages"
mkdir -p "$APPIMAGE_DIR"

# Specific versions variables
HAYASE_VERSION="6.4.69"

# Applications (Key = Local filename | Value = GitHub repo or direct URL)
declare -A APPS
APPS=(
    ["telmi-Sync"]="DantSu/Telmi-Sync" # https://telmi.fr/#download
    ["hayase"]="https://api.hayase.watch/files/linux-hayase-${HAYASE_VERSION}-linux.AppImage" # https://hayase.watch/download
)

echo "Starting Update Process"

# Clean up old AppImage files to prevent conflicts
rm -f "$APPIMAGE_DIR"/*.AppImage

for APP_NAME in "${!APPS[@]}"; do
    SOURCE="${APPS[$APP_NAME]}"

    echo "--------------------"
    echo "Processing: $APP_NAME..."

    # Check if the source is a direct URL or a GitHub repo
    if [[ $SOURCE == http* ]]; then
        # Direct URL (using the version variable defined above)
        URL=$SOURCE
    else
        # Use lastversion for GitHub repositories
        echo "Fetching latest release for $SOURCE..."
        # We filter for 'AppImage' assets specifically
        URL=$(lastversion get "$SOURCE" --assets --filter "AppImage")
    fi

    if [ -n "$URL" ]; then
        echo "Downloading: $URL"
        wget -c -P "$APPIMAGE_DIR/" "$URL"
    else
        echo "Error: Could not find AppImage URL for $APP_NAME"
    fi
done

# Set executable permissions
chmod +x -R "$APPIMAGE_DIR"/*

# Copy .desktop files
cp -v "$APPIMAGE_DIR"/*.desktop ~/.local/share/applications/

echo "--------------------"
echo "Update Completed!"
ls -larth "$APPIMAGE_DIR"/
