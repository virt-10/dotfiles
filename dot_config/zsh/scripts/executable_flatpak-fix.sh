#!/usr/bin/bash


# Install old MESA version to fix issue with tesla

BLUE="\033[34m"
RESET="\033[0m"

echo -e "\n\n\nSelect ${BLUE}All of the above${RESET}\n\n\n"
flatpak uninstall org.freedesktop.Platform.GL.default

# Install mesa for both system and user
flags=(
    "--system"
    "--user"
)

for flag in "${flags[@]}"; do
    echo -e "\n\n\n${BLUE}Installing MESA 23.08 for: ${flag}${RESET}\n\n\n"
    flatpak install "${flag}" --assumeyes --noninteractive \
    runtime/org.freedesktop.Platform.GL.default/x86_64/23.08 \
    runtime/org.freedesktop.Platform.GL.default/x86_64/23.08-extra
done
