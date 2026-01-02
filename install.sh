#!/bin/bash

echo "🚀 Starting System Restoration..."

# 1. Update the System
sudo pacman -Syu --noconfirm

# 2. Install Repo Apps (Using visual-studio-code-bin from AUR for better extension support)
APPS=("stow")
sudo pacman -S --needed --noconfirm "${APPS[@]}"

# 3. Handle Yay (AUR) & Install Brave + VS Code Bin
if ! command -v yay &> /dev/null; then
    echo "🛠️ Installing Yay..."
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay && makepkg -si --noconfirm && cd ~/dotfiles
fi

echo "🌐 Installing AUR Apps..."
# visual-studio-code-bin is better for Microsoft extensions like Copilot
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

# 4. Apply ALL Dotfiles
echo "🔗 Linking dotfiles with Stow..."
cd ~/dotfiles

# Folders that belong in ~ instead of ~/.config
HOME_PACKAGES=("bash" "backgrounds" "ayaka")

for dir in */; do
    target=${dir%/}
    [[ "$target" == .* ]] && continue

    # VS Code special path handling
    if [ "$target" == "vscode" ]; then
        DEST="$HOME/.config/Code/User/settings.json"
    elif [ "$target" == "bash" ]; then
        DEST="$HOME/.bashrc"
    elif [[ " ${HOME_PACKAGES[@]} " =~ " ${target} " ]]; then
        DEST="$HOME/$target"
    else
        DEST="$HOME/.config/$target"
    fi

    # --- SMART LINKING LOGIC ---
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

echo "✅ All systems updated and cleaned!"
