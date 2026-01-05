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
yay -S --needed ghostty

echo ""
echo "✅ All packages installed!"
echo ""
echo "Next steps:"
echo "  1. Run: ~/dotfiles/install.sh"
echo "  2. Reload: source ~/.bashrc && hyprctl reload"
