#!/bin/bash

echo "🚀 Starting System Restoration..."

# 1. Update the System
sudo pacman -Syu --noconfirm

# 2. Install your personal apps (Not covered by Omarchy)
# Note: visual-studio-code is often 'code' in Arch
APPS=("stow" "brave" "code")

echo "📦 Installing personal packages..."
sudo pacman -S --needed --noconfirm "${APPS[@]}"

# 3. Handle Yay (AUR) if needed
if ! command -v yay &> /dev/null; then
    echo "🛠️ Installing Yay..."
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay && makepkg -si --noconfirm && cd ~/dotfiles
fi

# 4. Apply ALL Dotfiles
echo "🔗 Linking all config folders..."
cd ~/dotfiles

# This loop stows every folder in your dotfiles automatically
for dir in */; do
    # Remove the trailing slash for stow
    target=${dir%/}
    # Don't stow the .git folder
    if [ "$target" != ".git" ]; then
        echo "Stowing $target..."
        stow "$target"
    fi
done

echo "✅ Setup Complete! Ghostty, Waybar, and Ayaka are now linked."
