#!/bin/bash

echo "🚀 Starting System Restoration..."

# 1. Update the System
sudo pacman -Syu --noconfirm

# 2. Install personal apps (Not covered by Omarchy)
# Use 'code' for VS Code and 'brave' for the browser
APPS=("stow" "brave" "code")

echo "📦 Installing personal packages..."
sudo pacman -S --needed --noconfirm "${APPS[@]}"

# 3. Handle Yay (AUR) for custom apps
if ! command -v yay &> /dev/null; then
    echo "🛠️ Installing Yay (AUR Helper)..."
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay && makepkg -si --noconfirm && cd ~/dotfiles
fi

# 4. Apply ALL Dotfiles with Conflict Handling
echo "🔗 Linking dotfiles with Stow..."
cd ~/dotfiles

for dir in */; do
    target=${dir%/}
    
    # Skip the .git folder
    if [ "$target" != ".git" ]; then
        
        # Check if a REAL file or folder exists at the destination
        # and delete it if it is NOT already a symbolic link
        if [ -e "$HOME/.config/$target" ] && [ ! -L "$HOME/.config/$target" ]; then
            echo "⚠️  Conflict found at ~/.config/$target. Removing real file/folder..."
            rm -rf "$HOME/.config/$target"
        fi

        echo "Stowing $target..."
        stow "$target"
    fi
done

echo "✅ Setup Complete! All configs (bash, ghostty, waybar, hypr, ayaka) are linked."
