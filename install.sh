#!/bin/bash

echo "🚀 Starting System Restoration..."

# 1. Update & Core Tools
sudo pacman -Syu --noconfirm
sudo pacman -S --needed --noconfirm stow

# 2. Yay & AUR Apps
if ! command -v yay &> /dev/null; then
    echo "🛠️ Installing Yay..."
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay && makepkg -si --noconfirm && cd ~/dotfiles
fi

echo "🌐 Installing Browser & VS Code..."
yay -S --needed --noconfirm brave-bin visual-studio-code-bin

# 3. Apply ALL Dotfiles
echo "🔗 Linking dotfiles with Stow..."
cd ~/dotfiles

declare -A FOLDER_MAP
FOLDER_MAP=(
    ["ayaka"]="$HOME/.config/ayaka"
    ["backgrounds"]="$HOME/Pictures/Wallpapers"
    ["bash"]="$HOME/.bashrc"
    ["ghostty"]="$HOME/.config/ghostty"
    ["hypr"]="$HOME/.config/hypr"
    ["vscode"]="$HOME/.config/Code/User/settings.json"
    ["waybar"]="$HOME/.config/waybar"
)

for target in "${!FOLDER_MAP[@]}"; do
    [ ! -d "$target" ] && continue
    DEST="${FOLDER_MAP[$target]}"
    mkdir -p "$(dirname "$DEST")"

    if [ -L "$DEST" ]; then
        # On your current laptop: Just keeps things synced
        stow "$target" 2>/dev/null
        echo "✅ $target is synced."
    elif [ -e "$DEST" ]; then
        # On your current laptop: Absorbs your "real" changes into dotfiles
        echo "📥 New data found at $DEST. Absorbing into dotfiles..."
        cp -ru "$DEST"/. "$HOME/dotfiles/$target/" 2>/dev/null
        rm -rf "$DEST"
        stow "$target"
    else
        # On a NEW laptop: Simply creates the link
        echo "📦 Stowing $target (New Installation)..."
        stow "$target"
    fi
done

echo "🏁 All systems go!"
