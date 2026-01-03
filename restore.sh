#!/bin/bash

echo "🚀 Restoring dotfiles..."

DOTFILES_DIR="$HOME/dotfiles"

# Create necessary directories
echo "📁 Creating directories..."
mkdir -p ~/.config
mkdir -p ~/Pictures
mkdir -p ~/.config/omarchy/themes

# Backup existing configs
echo "💾 Backing up existing configs..."
timestamp=$(date +%s)
[ -f ~/.bashrc ] && mv ~/.bashrc ~/.bashrc.backup.$timestamp 2>/dev/null
[ -f ~/.bash_profile ] && mv ~/.bash_profile ~/.bash_profile.backup.$timestamp 2>/dev/null
[ -d ~/.config/hypr ] && mv ~/.config/hypr ~/.config/hypr.backup.$timestamp 2>/dev/null
[ -d ~/.config/ghostty ] && mv ~/.config/ghostty ~/.config/ghostty.backup.$timestamp 2>/dev/null
[ -d ~/.config/waybar ] && mv ~/.config/waybar ~/.config/waybar.backup.$timestamp 2>/dev/null

# Create symlinks
echo "🔗 Creating symlinks..."

ln -sf "$DOTFILES_DIR/bash/.bashrc" ~/.bashrc
ln -sf "$DOTFILES_DIR/bash/.bash_profile" ~/.bash_profile
ln -sf "$DOTFILES_DIR/hypr" ~/.config/hypr
ln -sf "$DOTFILES_DIR/ghostty" ~/.config/ghostty
ln -sf "$DOTFILES_DIR/waybar" ~/.config/waybar
ln -sf "$DOTFILES_DIR/backgrounds" ~/Pictures/Wallpapers

# Fix theme.conf symlink
cd "$DOTFILES_DIR/my-themes/IMAD"
rm -f theme.conf
ln -sf hyprland.conf theme.conf
cd ~

# Link theme
ln -sf "$DOTFILES_DIR/my-themes/IMAD" ~/.config/omarchy/themes/imadtheme

echo "✅ Dotfiles restored successfully!"
echo ""
echo "📦 Next steps:"
echo "  1. Install packages: sudo pacman -S hyprland waybar"
echo "  2. Install Ghostty from AUR: yay -S ghostty"
echo "  3. Source bash: source ~/.bashrc"
echo "  4. Reload Hyprland: hyprctl reload"
