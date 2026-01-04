#!/bin/bash
set -e

echo "🚀 Installing Omarchy Dotfiles for Imad..."
echo ""

DOTFILES_DIR="$HOME/dotfiles"

# Check if we're in the right place
if [ ! -d "$DOTFILES_DIR" ]; then
    echo "❌ Error: $DOTFILES_DIR not found!"
    echo "Please clone your dotfiles first:"
    echo "  git clone git@github.com:imadvs/dotfiles.git ~/dotfiles"
    exit 1
fi

# Create necessary directories
echo "📁 Creating directories..."
mkdir -p ~/.config
mkdir -p ~/Pictures/Wallpapers
mkdir -p ~/.local/share/omarchy/themes

# Backup existing configs
echo "💾 Backing up existing configs..."
timestamp=$(date +%s)

backup_if_exists() {
    if [ -e "$1" ] && [ ! -L "$1" ]; then
        echo "  Backing up: $1"
        mv "$1" "$1.backup.$timestamp"
    elif [ -L "$1" ]; then
        echo "  Removing old symlink: $1"
        rm "$1"
    fi
}

backup_if_exists ~/.bashrc
backup_if_exists ~/.bash_profile
backup_if_exists ~/.config/hypr
backup_if_exists ~/.config/ghostty
backup_if_exists ~/.config/waybar
backup_if_exists ~/.config/nvim
backup_if_exists ~/.config/btop
backup_if_exists ~/.config/walker
backup_if_exists ~/.config/mako

# Create symlinks
echo ""
echo "🔗 Creating symlinks..."

create_link() {
    echo "  $1 -> $2"
    ln -sf "$1" "$2"
}

# Bash configs
create_link "$DOTFILES_DIR/bash/.bashrc" ~/.bashrc
create_link "$DOTFILES_DIR/bash/.bash_profile" ~/.bash_profile

# Hyprland and related configs
create_link "$DOTFILES_DIR/hypr" ~/.config/hypr
create_link "$DOTFILES_DIR/waybar" ~/.config/waybar
create_link "$DOTFILES_DIR/mako" ~/.config/mako
create_link "$DOTFILES_DIR/walker" ~/.config/walker

# Applications
create_link "$DOTFILES_DIR/ghostty" ~/.config/ghostty
create_link "$DOTFILES_DIR/nvim" ~/.config/nvim
create_link "$DOTFILES_DIR/btop" ~/.config/btop

# Wallpapers
create_link "$DOTFILES_DIR/backgrounds" ~/Pictures/Wallpapers

# Theme (if exists)
if [ -d "$DOTFILES_DIR/my-themes/IMAD" ]; then
    create_link "$DOTFILES_DIR/my-themes/IMAD" ~/.local/share/omarchy/themes/IMAD
fi

echo ""
echo "✅ Dotfiles installed successfully!"
echo ""
echo "📋 Next steps:"
echo "  1. Install packages: ~/dotfiles/install-packages.sh"
echo "  2. Reload configs: source ~/.bashrc && hyprctl reload"
echo "  3. Apply theme in Omarchy settings"
echo ""
echo "💡 Tips:"
echo "  - Run 'check-dotfiles' to verify your setup"
echo "  - Use 'dots' command to sync changes to GitHub"
echo "  - Run 'reload-hypr' to reload all Hyprland configs"
echo ""
