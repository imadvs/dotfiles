#!/bin/bash

echo "🚀 Starting System Restoration..."

# 1. Update the System
sudo pacman -Syu --noconfirm

# 2. Install Repo Apps (Removed Brave from here as it's in AUR)
APPS=("stow" "code")
sudo pacman -S --needed --noconfirm "${APPS[@]}"

# 3. Handle Yay (AUR) & Install Brave
if ! command -v yay &> /dev/null; then
    echo "🛠️ Installing Yay..."
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay && makepkg -si --noconfirm && cd ~/dotfiles
fi

echo "🌐 Installing Brave Browser..."
yay -S --needed --noconfirm brave-bin

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

# 4. Apply ALL Dotfiles
echo "🔗 Linking dotfiles with Stow..."
cd ~/dotfiles

# Update this list based on where your folders link to
HOME_PACKAGES=("bash" "backgrounds" "ayaka")

for dir in */; do
    target=${dir%/}
    [[ "$target" == .* ]] && continue

    # VS Code special path handling
    if [ "$target" == "vscode" ]; then
        DEST="$HOME/.config/Code/User/settings.json"
        # Since vscode stows a file, we check the specific file path
        if [ -L "$DEST" ]; then
            echo "✅ vscode settings already linked. Skipping."
            continue
        fi
    elif [[ " ${HOME_PACKAGES[@]} " =~ " ${target} " ]]; then
        DEST="$HOME/$target"
    else
        DEST="$HOME/.config/$target"
    fi

    if [ -L "$DEST" ]; then
        echo "✅ $target is already a link. Skipping."
    else
        if [ -e "$DEST" ]; then
            echo "⚠️  Conflict: $DEST exists. Backing up..."
            mv "$DEST" "${DEST}.bak"
        fi
        echo "📦 Stowing $target..."
        stow "$target"
    fi
done
