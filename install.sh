#!/bin/bash

echo "🚀 Starting System Restoration..."

# 1. Update & Install Core Tools (added fastfetch here)
sudo pacman -Syu --noconfirm
sudo pacman -S --needed --noconfirm stow fastfetch

# 2. Yay & AUR Apps
if ! command -v yay &> /dev/null; then
    echo "🛠️ Installing Yay..."
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay && makepkg -si --noconfirm && cd ~/dotfiles
fi

echo "🌐 Installing Browser & VS Code..."
yay -S --needed --noconfirm brave-bin visual-studio-code-bin

# --- VS Code Extensions ---
echo "📦 Installing VS Code Extensions..."
EXTENSIONS=(
    "github.copilot"
    "github.copilot-chat"
    "github.remotehub"
    "ms-vscode.azure-repos"
    "ms-vscode.cmake-tools"
    "ms-vscode.cpptools"
    "ms-vscode.cpptools-extension-pack"
    "ms-vscode.cpptools-themes"
    "ms-vscode.remote-repositories"
)

for ext in "${EXTENSIONS[@]}"; do
    code --install-extension "$ext" --force
done

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
        stow "$target" 2>/dev/null
        echo "✅ $target is synced."
    elif [ -e "$DEST" ]; then
        echo "📥 New data found at $DEST. Absorbing into dotfiles..."
        cp -ru "$DEST"/. "$HOME/dotfiles/$target/" 2>/dev/null
        rm -rf "$DEST"
        stow "$target"
    else
        echo "📦 Stowing $target (New Installation)..."
        stow "$target"
    fi
done

echo "🏁 All systems go!"
