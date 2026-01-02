#!/bin/bash
echo "🚀 Starting System Restoration..."

# 1. Update the System
sudo pacman -Syu --noconfirm

# 2. Install Core Tools
sudo pacman -S --needed --noconfirm stow

# 3. Handle Yay & AUR Apps
if ! command -v yay &> /dev/null; then
    echo "🛠️ Installing Yay..."
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay && makepkg -si --noconfirm && cd ~/dotfiles
fi

echo "🌐 Installing Browser & VS Code..."
yay -S --needed --noconfirm brave-bin visual-studio-code-bin

# 4. Apply ALL Dotfiles
echo "🔗 Linking dotfiles with Stow..."
cd ~/dotfiles

# --- THE MAP: Tells the script EXACTLY where to check for links ---
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
        echo "✅ $target is already a link. Skipping."
    elif [ -e "$DEST" ]; then
        echo "📥 New data found at $DEST. Absorbing into dotfiles..."
        # Copy newer files from real folder to dotfiles
        cp -ru "$DEST"/. "$HOME/dotfiles/$target/" 2>/dev/null
        # Remove the real folder/file to make room for the link
        rm -rf "$DEST"
        stow "$target"
    else
        echo "📦 Stowing $target (New Link)..."
        stow "$target"
    fi
done

echo "✅ All systems updated and cleaned!"
