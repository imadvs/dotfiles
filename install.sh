#!/bin/bash

echo "🚀 Starting System Restoration..."

# 1. Update the System
sudo pacman -Syu --noconfirm

# 2. Install personal apps (Changed 'brave' to 'brave-browser' for Arch)
APPS=("stow" "brave-browser" "code")
sudo pacman -S --needed --noconfirm "${APPS[@]}"

# --- VS Code Extensions ---
echo "📦 Installing VS Code Extensions..."
# ... (Keep your extensions loop here) ...

# 3. Handle Yay (AUR)
# ... (Keep your yay check here) ...

# 4. Apply ALL Dotfiles
echo "🔗 Linking dotfiles with Stow..."
cd ~/dotfiles

# Define packages that link to HOME instead of .config
HOME_PACKAGES=("bash" "backgrounds")

for dir in */; do
    target=${dir%/}
    
    # Ignore hidden folders like .git
    [[ "$target" == .* ]] && continue

    # Determine where the link should go
    if [[ " ${HOME_PACKAGES[@]} " =~ " ${target} " ]]; then
        DEST="$HOME/$target"
    else
        DEST="$HOME/.config/$target"
    fi

    # --- SMART LINKING LOGIC ---
    if [ -L "$DEST" ]; then
        echo "✅ $target is already a link. Skipping."
    else
        if [ -e "$DEST" ]; then
            echo "⚠️  Conflict: $DEST is a real folder/file. Backing up and linking..."
            mv "$DEST" "${DEST}.bak"
        fi
        echo "📦 Stowing $target..."
        stow "$target"
    fi
done

echo "✅ All systems updated and cleaned!"
