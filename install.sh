#!/bin/bash
echo "🚀 Starting System Restoration..."

# ... [Keep Sections 1, 2, and 3: Pacman, Yay, and VS Code same as before] ...

# 4. Apply ALL Dotfiles
echo "🔗 Linking dotfiles with Stow..."
cd ~/dotfiles

# --- THE MAP: Define where each folder should link to ---
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
    # Skip if the folder doesn't exist in dotfiles
    [ ! -d "$target" ] && continue

    DEST="${FOLDER_MAP[$target]}"
    
    # Ensure the parent directory exists (e.g., ~/.config/)
    mkdir -p "$(dirname "$DEST")"

    # --- SMART ABSORB & LINK LOGIC ---
    if [ -L "$DEST" ]; then
        echo "✅ $target is already a link. Skipping."
    elif [ -e "$DEST" ]; then
        echo "📥 New data found at $DEST. Absorbing into dotfiles..."
        
        # Copy new files from the real folder into the dotfiles folder (update only)
        cp -ru "$DEST"/. "$HOME/dotfiles/$target/" 2>/dev/null
        
        # Remove the real folder/file now that it's absorbed
        rm -rf "$DEST"
        
        echo "📦 Stowing $target..."
        stow "$target"
    else
        echo "📦 Stowing $target (New Link)..."
        stow "$target"
    fi
done

echo "✅ All systems updated and cleaned!"
