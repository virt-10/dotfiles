#!/usr/bin/bash

# wallpaper selector

# Directory to scan for images
IMAGE_DIR="$HOME/Pictures/Wallpapers"

# Destination directory
DEST_DIR="$HOME/.cache/wallpaper"

# Create destination directory if it doesn't exist
mkdir -p "$DEST_DIR"

# Enable nullglob to avoid patterns when no matches
shopt -s nullglob

# Scan for image files (you can add more extensions if needed)
IMAGES=("$IMAGE_DIR"/*.{jpg,jpeg,png})

# Check if any images were found
if [ ${#IMAGES[@]} -eq 0 ]; then
    echo "No images found in $IMAGE_DIR."
    exit 1
fi

# Function to display the selection menu
display_menu() {
    clear
    echo "Select an image to copy:"
    for i in "${!IMAGES[@]}"; do
        if [ "$i" -eq "$CURRENT_INDEX" ]; then
            echo "> ${IMAGES[$i]}"
        else
            echo "  ${IMAGES[$i]}"
        fi
    done
}

# Initialize variables
CURRENT_INDEX=0
TOTAL_IMAGES=${#IMAGES[@]}

# Display the initial menu
display_menu

# Read user input for navigation
while true; do
    read -rsn1 INPUT  # Read a single character
    case $INPUT in
        $'\e')  # If the first character is escape
            read -rsn2 -t 0.1 INPUT  # Read the next 2 characters
            if [[ $INPUT == '[A' ]]; then  # Up arrow
                ((CURRENT_INDEX--))
                if [ "$CURRENT_INDEX" -lt 0 ]; then
                    CURRENT_INDEX=$((TOTAL_IMAGES - 1))
                fi
            elif [[ $INPUT == '[B' ]]; then  # Down arrow
                ((CURRENT_INDEX++))
                if [ "$CURRENT_INDEX" -ge "$TOTAL_IMAGES" ]; then
                    CURRENT_INDEX=0
                fi
            fi
            ;;
        '')  # Enter key
            cp --force "${IMAGES[$CURRENT_INDEX]}" "$DEST_DIR/wallpaper"  # Copy with fixed name 'wallpaper'
            echo "Copied ${IMAGES[$CURRENT_INDEX]} to $DEST_DIR/wallpaper."
            break
            ;;
        *)  # Any other key
            echo "Invalid selection."
            ;;
    esac
    display_menu  # Redisplay the menu after input
done
