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

# Backup setup
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="$HOME/dotfiles_backups/$TIMESTAMP"

echo "💾 Backing up existing configs to: $BACKUP_DIR"

backup_target() {
    local target=$1
    local name=$(basename "$target")
    local parent_dir=$(dirname "$target")
    
    # Check if target exists and is NOT a symlink to our dotfiles
    if [ -e "$target" ] || [ -L "$target" ]; then
        # If it's already a correct symlink, do nothing or just remove it to refresh?
        # Let's remove symlinks to ensure we refresh them, but move real files to backup.
        
        if [ -L "$target" ]; then
            # It's a symlink
            local current_link=$(readlink -f "$target")
            if [[ "$current_link" == "$DOTFILES_DIR"* ]]; then
                echo "  Refreshing link: $target"
                rm "$target"
            else
                echo "  Moving external symlink: $target -> $BACKUP_DIR"
                mkdir -p "$BACKUP_DIR/${parent_dir#$HOME/}"
                mv "$target" "$BACKUP_DIR/${parent_dir#$HOME/}/$name"
            fi
        else
            # It's a real file/directory
            echo "  Backing up: $target -> $BACKUP_DIR"
            mkdir -p "$BACKUP_DIR/${parent_dir#$HOME/}"
            mv "$target" "$BACKUP_DIR/${parent_dir#$HOME/}/$name"
        fi
    fi
}

# List of files/configs to backup before linking
backup_target ~/.bashrc
backup_target ~/.bash_profile
backup_target ~/.config/hypr
backup_target ~/.config/ghostty
backup_target ~/.config/waybar
backup_target ~/.config/nvim
backup_target ~/.config/btop
backup_target ~/.config/walker
backup_target ~/.config/mako

# VS Code & Antigravity (Files, not whole dirs)
backup_target ~/.config/Code/User/settings.json
backup_target ~/.config/Code/User/snippets
backup_target ~/.config/Antigravity/User/settings.json
backup_target ~/.config/Antigravity/User/snippets

# Create symlinks
echo ""
echo "🔗 Creating symlinks..."

create_link() {
    local source=$1
    local target=$2
    
    # Ensure parent dir exists
    mkdir -p "$(dirname "$target")"
    
    echo "  $source -> $target"
    ln -sf "$source" "$target"
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

# VS Code & Antigravity (Specific files only to avoid syncing cache)
create_link "$DOTFILES_DIR/vscode/settings.json" ~/.config/Code/User/settings.json
create_link "$DOTFILES_DIR/vscode/snippets" ~/.config/Code/User/snippets
create_link "$DOTFILES_DIR/antigravity/settings.json" ~/.config/Antigravity/User/settings.json
create_link "$DOTFILES_DIR/antigravity/snippets" ~/.config/Antigravity/User/snippets

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
