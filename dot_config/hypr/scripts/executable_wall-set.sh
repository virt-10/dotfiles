#!/usr/bin/bash

# wallpaper selector

# gum style options
gum style \
    --foreground 212 --border-foreground 212 --border double \
    --align center --width 100 --margin "1 2" --padding "2 4" --bold

# wallpaper selector
IMAGE_DIR="${HOME}/Pictures/Wallpapers"
DEST_DIR="${HOME}/.cache/wallpaper"
mkdir -p "${DEST_DIR}"

# Enable nullglob to avoid patterns when no matches
shopt -s nullglob
# Scan for image files (you can add more extensions if needed)
IMAGES=("${IMAGE_DIR}"/*.{jpg,jpeg,png})
# Check if any images were found
if [[ ${#IMAGES[@]} -eq 0 ]]; then
    echo "No images found in ${IMAGE_DIR}."
    exit 1
fi

# gum list selector
IMAGE=$(gum choose --height=30 --selected.bold --selected.underline "${IMAGES[@]}")

# overwrite wallpaper
cp --force "${IMAGE}" "${DEST_DIR}/wallpaper"
echo "Copied ${IMAGE} to ${DEST_DIR}/wallpaper."
