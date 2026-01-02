#!/bin/bash

echo "🚀 Starting System Restoration..."

# 1. Update & Install Core Tools
sudo pacman -Syu --noconfirm
sudo pacman -S --needed --noconfirm stow fastfetch curl git

# 2. Yay & AUR Apps
if ! command -v yay &> /dev/null; then
    echo "🛠️ Installing Yay..."
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay && makepkg -si --noconfirm && cd ~/dotfiles
fi

echo "🌐 Installing Browser & VS Code..."
yay -S --needed --noconfirm brave-bin visual-studio-code-bin

# --- Google Antigravity Manual Install ---
if ! command -v antigravity &> /dev/null; then
    echo "🚀 Antigravity not found. Downloading official Google binary..."
    curl -L "https://antigravity.google/download/linux" -o /tmp/antigravity.tar.gz
    sudo tar -xzf /tmp/antigravity.tar.gz -C /opt/
    sudo ln -sf /opt/antigravity/antigravity /usr/bin/antigravity
    echo "✅ Antigravity installed!"
else
    echo "✅ Antigravity is already installed."
fi

# --- IDE Extensions (VS Code & Antigravity) ---
echo "📦 Installing IDE Extensions..."
EXTENSIONS=("github.copilot" "github.copilot-chat" "github.remotehub" "ms-vscode.azure-repos" "ms-vscode.cmake-tools" "ms-vscode.cpptools" "ms-vscode.cpptools-extension-pack" "ms-vscode.cpptools-themes" "ms-vscode.remote-repositories")
for ext in "${EXTENSIONS[@]}"; do
    code --install-extension "$ext" --force
    if command -v antigravity &> /dev/null; then
        antigravity --install-extension "$ext" --force
    fi
done

# 3. Apply Dotfiles with Safety Vault Logic
echo "🔗 Linking dotfiles with Stow..."
cd ~/dotfiles

# Create a timestamped backup folder for this specific run
BACKUP_DIR="$HOME/config_backups/$(date +%Y-%m-%d_%H-%M)"

# Load the dynamic map
declare -A FOLDER_MAP
if [ -f "$HOME/dotfiles/map.conf" ]; then
    while IFS='=' read -r key value; do
        eval actual_value="$value"
        FOLDER_MAP["$key"]="$actual_value"
    done < "$HOME/dotfiles/map.conf"
fi

for target in "${!FOLDER_MAP[@]}"; do
    [ ! -d "$target" ] && continue
    DEST="${FOLDER_MAP[$target]}"

    # --- SAFETY VAULT: Before touching anything, save a snapshot ---
    if [ -e "$DEST" ] && [ ! -L "$DEST" ]; then
        echo "🛡️ Safety Vault: Snapshotting $target to $BACKUP_DIR"
        mkdir -p "$BACKUP_DIR"
        cp -rp "$DEST" "$BACKUP_DIR/"
    fi

    mkdir -p "$(dirname "$DEST")"

    if [ -L "$DEST" ]; then
        # Already a link, just refresh it
        stow "$target" 2>/dev/null
        echo "✅ $target is synced."
    elif [ -e "$DEST" ]; then
        # Real folder found: Absorb it
        echo "📥 New data found at $DEST. Absorbing into dotfiles..."
        cp -ru "$DEST"/. "$HOME/dotfiles/$target/" 2>/dev/null
        rm -rf "$DEST"
        stow "$target"
        echo "✅ $target is now managed and synced."
    else
        # Fresh install: Just link from repo
        stow "$target"
        echo "✅ $target is synced (New Installation)."
    fi
done

# 4. Housekeeping: Remove backups older than 30 days
if [ -d "$HOME/config_backups" ]; then
    find "$HOME/config_backups" -type d -mtime +30 -exec rm -rf {} +
    echo "🧹 Cleaned old backups from the Safety Vault."
fi

echo "🏁 All systems go!"
