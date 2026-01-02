#!/bin/bash

echo "🚀 Starting System Restoration..."

# 1. Update the System
sudo pacman -Syu --noconfirm

# 2. Install personal apps
APPS=("stow" "brave" "code")
sudo pacman -S --needed --noconfirm "${APPS[@]}"

# --- NEW: VS Code Extensions ---
echo "📦 Installing VS Code Extensions..."
EXTENSIONS=(
    "GitHub.copilot"
    "GitHub.copilot-chat"
    "GitHub.remotehub"
    "ms-vscode.azure-repos"
    "ms-vscode.cmake-tools"
    "ms-vscode.cpptools"
    "ms-vscode.cpptools-extension-pack"
    "ms-vscode.cpptools-themes"
    "ms-vscode.remote-repositories"
)

for ext in "${EXTENSIONS[@]}"; do
    code --install-extension "$ext" --force
done
# -------------------------------

# 3. Handle Yay (AUR)
if ! command -v yay &> /dev/null; then
    echo "🛠️ Installing Yay..."
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay && makepkg -si --noconfirm && cd ~/dotfiles
fi

# Ensure directories exist so stow doesn't link to the wrong place
mkdir -p ~/Pictures/Wallpapers

# 4. Apply ALL Dotfiles
echo "🔗 Linking dotfiles with Stow..."
cd ~/dotfiles

for dir in */; do
    target=${dir%/}
    
    if [ "$target" != ".git" ]; then
        # Check for conflicts in TWO places: Home and .config
        # 1. Check ~/.config/folder (e.g., ~/.config/hypr)
        if [ -d "$HOME/.config/$target" ] && [ ! -L "$HOME/.config/$target" ]; then
            echo "⚠️  Conflict found at ~/.config/$target. Removing real folder..."
            rm -rf "$HOME/.config/$target"
        fi

        # 2. Check ~/folder (e.g., ~/Pictures)
        if [ -d "$HOME/$target" ] && [ ! -L "$HOME/$target" ]; then
            echo "⚠️  Conflict found at ~/$target. Removing real folder..."
            rm -rf "$HOME/$target"
        fi

        echo "Stowing $target..."
        stow "$target"
    fi
done
