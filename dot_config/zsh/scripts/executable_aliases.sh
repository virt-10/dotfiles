#!/usr/bin/env sh


# aliases
alias zed='flatpak run dev.zed.Zed -n '
alias reload='systemctl --user daemon-reload'
alias wall-set='~/.config/hypr/scripts/wall-set.sh'
alias get-icons='wget -qO- https://git.io/papirus-icon-theme-install | env DESTDIR="$HOME/.local/share/icons" sh'

# flatpak fix for tesla
alias fix-flatpak='~/.config/zsh/scripts/flatpak-fix.sh'
