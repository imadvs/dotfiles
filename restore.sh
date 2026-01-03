#!/bin/bash

set -e  # Exit on any error

echo "🚀 Restoring dotfiles for Omarchy OS..."
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
mkdir -p ~/Pictures
mkdir -p ~/.config/omarchy/themes

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
backup_if_exists ~/Pictures/Wallpapers
backup_if_exists ~/.config/omarchy/themes/imadtheme

# Create symlinks
echo ""
echo "🔗 Creating symlinks..."

create_link() {
    echo "  $1 -> $2"
    ln -sf "$1" "$2"
}

create_link "$DOTFILES_DIR/bash/.bashrc" ~/.bashrc
create_link "$DOTFILES_DIR/bash/.bash_profile" ~/.bash_profile
create_link "$DOTFILES_DIR/hypr" ~/.config/hypr
create_link "$DOTFILES_DIR/ghostty" ~/.config/ghostty
create_link "$DOTFILES_DIR/waybar" ~/.config/waybar
create_link "$DOTFILES_DIR/nvim" ~/.config/nvim
create_link "$DOTFILES_DIR/backgrounds" ~/Pictures/Wallpapers

# Setup IMAD theme
echo ""
echo "🎨 Setting up IMAD theme..."
cd "$DOTFILES_DIR/my-themes/IMAD"
rm -f theme.conf
ln -sf hyprland.conf theme.conf

# Fix nvim theme symlink
rm -f "$DOTFILES_DIR/nvim/lua/plugins/theme.lua"
ln -sf "$DOTFILES_DIR/my-themes/IMAD/neovim.lua" "$DOTFILES_DIR/nvim/lua/plugins/theme.lua"

# Link theme to Omarchy
create_link "$DOTFILES_DIR/my-themes/IMAD" ~/.config/omarchy/themes/imadtheme

echo ""
echo "✅ Dotfiles restored successfully!"
echo ""
ech

cd ~/dotfiles

# Finish creating PACKAGES.md
cat > PACKAGES.md << 'EOF'
# Required Packages

## Core System (Pacman)
```bash
sudo pacman -S \
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
```

## AUR Packages (yay/paru)
```bash
yay -S ghostty
```

## Optional Tools
```bash
sudo pacman -S \
    lazygit \
    htop \
    ncdu
```
