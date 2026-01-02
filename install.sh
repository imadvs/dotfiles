#!/bin/bash

echo "🚀 Starting System Restoration..."

# 1. Update the System
sudo pacman -Syu --noconfirm

# 2. Install Core Tools (stow is essential for linking)
sudo pacman -S --needed --noconfirm stow

# 3. Handle Yay (AUR) & Install Brave + VS Code
if ! command -v yay &> /dev/null; then
    echo "🛠️ Installing Yay..."
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay && makepkg -si --noconfirm && cd ~/dotfiles
fi

echo "🌐 Installing Browser & VS Code (AUR)..."
# Using visual-studio-code-bin for full Marketplace support
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

# 4. Apply ALL Dotfiles with Smart Linking
echo "🔗 Linking dotfiles with Stow..."
cd ~/dotfiles

# --- THE MAP: Mapping dotfile folders to their real destinations ---
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
    # Skip if the folder doesn't exist in your dotfiles directory
    [ ! -d "$target" ] && continue
    
    DEST="${FOLDER_MAP[$target]}"
    
    # Create the parent directory (e.g., ~/.config) if it's missing
    mkdir -p "$(dirname "$DEST")"

    if [ -L "$DEST" ]; then
        # If it's already a link, just refresh it to pick up new files
        stow "$target" 2>/dev/null
        echo "✅ $target is synced. Skipping."
    elif [ -e "$DEST" ]; then
        # ABSORB LOGIC: If a real folder exists, take its files before linking
        echo "📥 New data found at $DEST. Absorbing into dotfiles..."
        
        # Ensure the dotfiles destination exists
        mkdir -p "$HOME/dotfiles/$target"
        
        # Copy newer files from the real folder into your dotfiles repo
        cp -ru "$DEST"/. "$HOME/dotfiles/$target/" 2>/dev/null
        
        # Remove the real folder/file now that it is absorbed
        rm -rf "$DEST"
        
        echo "📦 Stowing $target..."
        stow "$target"
    else
        # If nothing exists at the destination, just create the link
        echo "📦 Stowing $target (New Link)..."
        stow "$target"
    fi
done

echo "🏁 Restoration Complete! All systems clean."
