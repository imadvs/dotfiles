#!/bin/bash

echo "📦 Installing packages for Imad's dotfiles..."
echo ""

# Check if yay is installed
if ! command -v yay &> /dev/null; then
    echo "❌ yay not found! Install it first:"
    echo "   sudo pacman -S --needed git base-devel"
    echo "   git clone https://aur.archlinux.org/yay.git"
    echo "   cd yay && makepkg -si"
    exit 1
fi

# Core packages
echo "Installing core packages..."
sudo pacman -S --needed \
    hyprland \
    waybar \
    neovim \
    git \
    fastfetch \
    btop \
    tree \
    ripgrep \
    fd \
    fzf

# AUR packages
echo ""
echo "Installing AUR packages..."
yay -S --needed \
    ghostty \
    brave-bin \
    google-chrome \
    visual-studio-code-bin \
    antigravity

# Install VS Code Extensions
if command -v code &> /dev/null; then
    echo ""
    echo "Installing VS Code extensions..."
    if [ -f "$HOME/dotfiles/vscode/extensions.txt" ]; then
        while read -r extension; do
            code --install-extension "$extension"
        done < "$HOME/dotfiles/vscode/extensions.txt"
    fi
fi

# Install Antigravity Extensions
if command -v antigravity &> /dev/null; then
    echo ""
    echo "Installing Antigravity extensions..."
    if [ -f "$HOME/dotfiles/antigravity/extensions.txt" ]; then
        while read -r extension; do
            antigravity --install-extension "$extension"
        done < "$HOME/dotfiles/antigravity/extensions.txt"
    fi
fi

echo ""
echo "✅ All packages installed!"
echo ""
echo "Next steps:"
echo "  1. Run: ~/dotfiles/install.sh"
echo "  2. Reload: source ~/.bashrc && hyprctl reload"
