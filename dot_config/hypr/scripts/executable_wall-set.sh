#!/usr/bin/bash


DEST_DIR="${HOME}/.cache/blublu"
mkdir -p "${DEST_DIR}"

# wallpaper selector
wallpaper_Selector() {
    WALLPAPER_DIR="${HOME}/Pictures/Wallpapers"

    # Enable nullglob to avoid patterns when no matches
    shopt -s nullglob
    # Scan for image files (you can add more extensions if needed)
    IMAGES=("${WALLPAPER_DIR}"/*.{jpg,jpeg,png})
    # Check if any images were found
    if [[ ${#IMAGES[@]} -eq 0 ]]; then
        echo "No images found in ${WALLPAPER_DIR}."
        exit 1
    fi

    # gum list selector
    IMAGE=$(gum choose --height=30 --selected.bold --selected.underline "${IMAGES[@]}")

    # overwrite wallpaper
    cp --force "${IMAGE}" "${DEST_DIR}/wallpaper"
    echo "Copied ${IMAGE} to ${DEST_DIR}/wallpaper."

    # restart wallpaper app
    killall -e hyprpaper || true > /dev/null 2>&1
    sleep 1
    nohup hyprpaper > /dev/null 2>&1 & disown
    sleep 1
}

# profile selector
profile_Selector() {
    PROFILE_DIR="${HOME}/Pictures/Profiles"

    # Enable nullglob to avoid patterns when no matches
    shopt -s nullglob
    # Scan for image files (you can add more extensions if needed)
    IMAGES=("${PROFILE_DIR}"/*.{jpg,jpeg,png})
    # Check if any images were found
    if [[ ${#IMAGES[@]} -eq 0 ]]; then
        echo "No images found in ${PROFILE_DIR}."
        exit 1
    fi

    # gum list selector
    IMAGE=$(gum choose --height=30 --selected.bold --selected.underline "${IMAGES[@]}")

    # overwrite wallpaper
    cp --force "${IMAGE}" "${DEST_DIR}/profile"
    echo "Copied ${IMAGE} to ${DEST_DIR}/profile"
}

SELECTION=$(gum choose --height=30 --selected.bold --selected.underline "profile" "wallpaper")

if [[ "${SELECTION}" == "profile" ]]; then
    echo "You selected Profile."
    profile_Selector
elif [[ "${SELECTION}" == "wallpaper" ]]; then
    echo "You selected Wallpaper."
    wallpaper_Selector
else
    echo "No valid selection made."
fi
