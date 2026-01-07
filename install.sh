#!/bin/bash
set -e

echo "🚀 Installing Omarchy Dotfiles for Imad..."
echo ""

DOTFILES_DIR="$HOME/dotfiles"

# --- PART 1: PRE-CHECKS & PACKAGES ---

# Check if we're in the right place
if [ ! -d "$DOTFILES_DIR" ]; then
    echo "❌ Error: $DOTFILES_DIR not found!"
    echo "Please clone your dotfiles first:"
    echo "  git clone git@github.com:imadvs/dotfiles.git ~/dotfiles"
    exit 1
fi

echo "📦 Checking system and packages..."

# Check if yay is installed
if ! command -v yay &> /dev/null; then
    echo "⚠️  yay not found! Attempting to install..."
    if command -v pacman &> /dev/null; then
         sudo pacman -S --needed git base-devel
         git clone https://aur.archlinux.org/yay.git
         cd yay && makepkg -si
         cd .. && rm -rf yay
    else
         echo "❌ pacman not found. Is this Arch/Omarchy?"
         exit 1
    fi
fi

# Remove pre-installed bloatware (as requested)
echo ""
echo "🧹 Removing pre-installed apps..."
BLOAT_PKGS="chromium 1password typora hey"
for pkg in $BLOAT_PKGS; do
    if pacman -Qi $pkg &> /dev/null; then
        echo "  Removing $pkg..."
        sudo pacman -Rns --noconfirm $pkg || echo "  ⚠️ Could not remove $pkg (might be protected or dependencies)"
    else
        echo "  $pkg not found (already removed)"
    fi
done

# Core packages
echo ""
echo "📦 Installing core packages..."
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
    fzf \
    yazi \
    ffmpeg \
    7zip \
    jq \
    poppler \
    imagemagick \
    zoxide

# AUR packages
echo ""
echo "📦 Installing AUR packages..."
yay -S --needed \
    ghostty \
    brave-bin \
    google-chrome \
    visual-studio-code-bin \
    antigravity

# Install VS Code Extensions
if command -v code &> /dev/null; then
    echo ""
    echo "🧩 Installing VS Code extensions..."
    if [ -f "$DOTFILES_DIR/vscode/extensions.txt" ]; then
        while read -r extension; do
            code --install-extension "$extension"
        done < "$DOTFILES_DIR/vscode/extensions.txt"
    fi
fi

# Install Antigravity Extensions
if command -v antigravity &> /dev/null; then
    echo ""
    echo "🧩 Installing Antigravity extensions..."
    if [ -f "$DOTFILES_DIR/antigravity/extensions.txt" ]; then
        while read -r extension; do
            antigravity --install-extension "$extension"
        done < "$DOTFILES_DIR/antigravity/extensions.txt"
    fi
fi

# Set Default Browser
if command -v xdg-mime &> /dev/null; then
    echo ""
    echo "🎨 Setting Google Chrome as default browser..."
    xdg-mime default google-chrome.desktop x-scheme-handler/http
    xdg-mime default google-chrome.desktop x-scheme-handler/https
    xdg-mime default google-chrome.desktop text/html
    echo "  ✓ Default browser set"
fi


# --- PART 2: DOTFILES & CONFIGS ---

echo ""
echo "📂 Setting up Dotfiles..."

# Create necessary directories
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

# Yazi (Uncomment after moving config to ~/dotfiles/yazi)
# create_link "$DOTFILES_DIR/yazi" ~/.config/yazi

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
echo "  1. Reload configs: source ~/.bashrc && hyprctl reload"
echo "  2. Apply theme in Omarchy settings"
echo ""
