#!/bin/bash
set -e

# Colors for pretty output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Installing Dotfiles for CachyOS (Imad)...${NC}"
echo ""

DOTFILES_DIR="$HOME/dotfiles"

# --- PART 1: PRE-CHECKS & PACKAGES ---

# Check if we're in the right place
if [ ! -d "$DOTFILES_DIR" ]; then
    echo -e "${RED}❌ Error: $DOTFILES_DIR not found!${NC}"
    echo "Please clone your dotfiles first:"
    echo "  git clone git@github.com:imadvs/dotfiles.git ~/dotfiles"
    exit 1
fi

echo -e "${BLUE}📦 Checking system and packages...${NC}"

# Detect AUR Helper (CachyOS uses paru by default, but we support yay)
AUR_HELPER=""
if command -v paru &> /dev/null; then
    AUR_HELPER="paru"
    echo -e "${GREEN}  ✓ Found paru${NC}"
elif command -v yay &> /dev/null; then
    AUR_HELPER="yay"
    echo -e "${GREEN}  ✓ Found yay${NC}"
else
    echo -e "${YELLOW}⚠️  Neither paru nor yay found! Installing yay...${NC}"
    sudo pacman -S --needed git base-devel
    git clone https://aur.archlinux.org/yay.git
    cd yay && makepkg -si
    cd .. && rm -rf yay
    AUR_HELPER="yay"
fi

# Remove pre-installed bloatware
# NOTE: CachyOS is usually clean. Only uncomment if you want to remove cachy-browser or others.
echo ""
echo -e "${YELLOW}🧹 Checking for bloatware...${NC}"
BLOAT_PKGS="chromium cachy-browser" # Added cachy-browser if you prefer Chrome
for pkg in $BLOAT_PKGS; do
    if pacman -Qi $pkg &> /dev/null; then
        echo "  Removing $pkg..."
        sudo pacman -Rns --noconfirm $pkg || echo "  ⚠️ Could not remove $pkg"
    else
        echo "  $pkg not found (clean)"
    fi
done

# Core packages
echo ""
echo -e "${BLUE}📦 Installing core packages...${NC}"
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
    zoxide \
    cachyos-settings # Ensures CachyOS specific tweaks are present

# AUR packages
echo ""
echo -e "${BLUE}📦 Installing AUR packages (using $AUR_HELPER)...${NC}"
$AUR_HELPER -S --needed \
    ghostty \
    brave-bin \
    google-chrome \
    visual-studio-code-bin \
    antigravity

# Install VS Code Extensions
if command -v code &> /dev/null; then
    echo ""
    echo -e "${BLUE}🧩 Installing VS Code extensions...${NC}"
    if [ -f "$DOTFILES_DIR/vscode/extensions.txt" ]; then
        while read -r extension; do
            code --install-extension "$extension"
        done < "$DOTFILES_DIR/vscode/extensions.txt"
    fi
fi

# Install Antigravity Extensions
if command -v antigravity &> /dev/null; then
    echo ""
    echo -e "${BLUE}🧩 Installing Antigravity extensions...${NC}"
    if [ -f "$DOTFILES_DIR/antigravity/extensions.txt" ]; then
        while read -r extension; do
            antigravity --install-extension "$extension"
        done < "$DOTFILES_DIR/antigravity/extensions.txt"
    fi
fi

# Set Default Browser
if command -v xdg-mime &> /dev/null; then
    echo ""
    echo -e "${BLUE}🎨 Setting Google Chrome as default browser...${NC}"
    xdg-mime default google-chrome.desktop x-scheme-handler/http
    xdg-mime default google-chrome.desktop x-scheme-handler/https
    xdg-mime default google-chrome.desktop text/html
    echo "  ✓ Default browser set"
fi


# --- PART 2: DOTFILES & CONFIGS ---

echo ""
echo -e "${BLUE}📂 Setting up Dotfiles...${NC}"

# Create necessary directories
mkdir -p ~/.config
mkdir -p ~/Pictures/Wallpapers
# Keeping 'omarchy' path to avoid breaking internal config references
mkdir -p ~/.local/share/omarchy/themes 

# Backup setup
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="$HOME/dotfiles_backups/$TIMESTAMP"

echo -e "${YELLOW}💾 Backing up existing configs to: $BACKUP_DIR${NC}"

backup_target() {
    local target=$1
    local name=$(basename "$target")
    local parent_dir=$(dirname "$target")
    
    # Check if target exists
    if [ -e "$target" ] || [ -L "$target" ]; then
        # Check if it's already a link to our DOTFILES_DIR
        if [ -L "$target" ]; then
            local current_link=$(readlink -f "$target")
            if [[ "$current_link" == "$DOTFILES_DIR"* ]]; then
                echo "  Refreshing link: $target"
                rm "$target"
                return
            fi
        fi
        
        # Otherwise back it up
        echo "  Backing up: $target"
        mkdir -p "$BACKUP_DIR/${parent_dir#$HOME/}"
        mv "$target" "$BACKUP_DIR/${parent_dir#$HOME/}/$name"
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
echo -e "${BLUE}🔗 Creating symlinks...${NC}"

create_link() {
    local source=$1
    local target=$2
    
    # Ensure parent dir exists
    mkdir -p "$(dirname "$target")"
    
    if [ ! -e "$source" ]; then
        echo -e "${RED}  ⚠️ Source missing: $source${NC}"
        return
    fi

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

# VS Code & Antigravity
create_link "$DOTFILES_DIR/vscode/settings.json" ~/.config/Code/User/settings.json
create_link "$DOTFILES_DIR/vscode/snippets" ~/.config/Code/User/snippets
create_link "$DOTFILES_DIR/antigravity/settings.json" ~/.config/Antigravity/User/settings.json
create_link "$DOTFILES_DIR/antigravity/snippets" ~/.config/Antigravity/User/snippets

# Wallpapers
create_link "$DOTFILES_DIR/backgrounds" ~/Pictures/Wallpapers

# Theme (if exists)
if [ -d "$DOTFILES_DIR/my-themes" ]; then
    echo "🎨 Installing themes..."
    for theme in "$DOTFILES_DIR/my-themes"/*; do
        if [ -d "$theme" ]; then
            theme_name=$(basename "$theme")
            create_link "$theme" "$HOME/.local/share/omarchy/themes/$theme_name"
        fi
    done
fi

# --- Dynamic Theme Linking ---
echo ""
echo -e "${BLUE}🎨 Setting up Dynamic Theme Links...${NC}"

# Ensure the dynamic theme directory structure exists
# NOTE: Keeping path as 'omarchy' to ensure hyprland.conf sources work
if [ ! -d "$HOME/.config/omarchy/current" ]; then
    echo "  Initializing dynamic theme structure..."
    mkdir -p "$HOME/.config/omarchy"
    mkdir -p "$HOME/.config/omarchy/current"
    
    # Link default theme
    if [ ! -L "$HOME/.config/omarchy/current/theme" ]; then
         if [ -d "$HOME/.local/share/omarchy/themes/IMAD" ]; then
             ln -sf "$HOME/.local/share/omarchy/themes/IMAD" "$HOME/.config/omarchy/current/theme"
             echo "  Default theme set to: IMAD"
         elif [ -d "$HOME/.local/share/omarchy/themes/forest-green" ]; then
             ln -sf "$HOME/.local/share/omarchy/themes/forest-green" "$HOME/.config/omarchy/current/theme"
             echo "  Default theme set to: forest-green"
         fi
    fi
fi

# Create usage links
if [ -L "$HOME/.config/omarchy/current/theme" ]; then
    echo "  Linking apps to dynamic theme..."
    ln -sf ~/.config/omarchy/current/theme/hyprland.conf ~/.config/hypr/theme.conf
    ln -sf ~/.local/share/omarchy/config/waybar/style.css ~/.config/waybar/style.css
    ln -sf ~/.config/omarchy/current/theme/style.css ~/.config/swayosd/style.css
    ln -sf ~/.config/omarchy/current/theme/walker.css ~/.config/walker/style.css 
    ln -sf ~/.config/omarchy/current/theme/btop.theme ~/.config/btop/themes/current.theme
else
    echo -e "${YELLOW}⚠️  No current theme selected. Please use your theme switcher to select a theme.${NC}"
fi

# --- Final Verification ---
echo ""
echo -e "${BLUE}🔍 Verifying critical links...${NC}"
check_link() {
    if [ ! -e "$1" ]; then
        echo -e "${RED}  ❌ Broken or missing: $1${NC}"
    else
        echo -e "${GREEN}  ✅ Valid: $1${NC}"
    fi
}
check_link ~/.config/hypr/theme.conf
check_link ~/.config/waybar/style.css
check_link ~/.config/omarchy/current/theme

echo ""
echo -e "${GREEN}✅ CachyOS Dotfiles installed successfully!${NC}"
echo ""
echo "📋 Next steps:"
echo "  1. If you are using Fish/Zsh (Cachy defaults), run: source ~/.bashrc (or add to your shell config)"
echo "  2. Run: hyprctl reload"
echo "  3. Reboot to ensure all drivers and services load correctly."
echo ""