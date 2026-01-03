#!/bin/bash
# link.sh v4 - Correct Target Logic

cd "$HOME/dotfiles" || exit

if [ ! -f "map.conf" ]; then
    echo "❌ map.conf not found!"
    exit 1
fi

echo "🔗 Activating Dotfiles..."

while IFS='=' read -r key value; do
    # Skip comments/empty
    [[ $key =~ ^#.*$ ]] || [[ -z $key ]] && continue

    PKG="$key"
    
    # Expand ~ and $HOME
    DEST="${value/#\~/$HOME}"
    DEST="${DEST//\$HOME/$HOME}"
    
    BASENAME="$(basename "$DEST")"

    # 1. Check if package exists in dotfiles
    if [ ! -d "$PKG" ]; then
        echo "⚠️  Skipping '$PKG': Folder not found in ~/dotfiles"
        continue
    fi

    # 2. Determine Stow Target (THE FIX)
    # Only treat as a file if the LAST part starts with a dot or has an extension
    if [[ "$BASENAME" == .* ]] || [[ "$BASENAME" == *.* ]]; then
        STOW_TARGET=$(dirname "$DEST")
    else
        STOW_TARGET="$DEST"
    fi

    echo "➡️  Processing: $PKG"
    echo "    Target: $STOW_TARGET"

    # 3. Conflict Resolution
    if [ -e "$DEST" ] && [ ! -L "$DEST" ]; then
        echo "    ⚠️ Conflict: Backing up existing $(basename "$DEST") to .old"
        mv "$DEST" "${DEST}.old"
    fi

    # 4. Create Directory & Link
    mkdir -p "$STOW_TARGET"
    stow -R -v -t "$STOW_TARGET" "$PKG" 2>/dev/null

    if [ $? -eq 0 ]; then
        echo "    ✅ Success"
    else
        echo "    ❌ Failed"
    fi

done < map.conf

echo "🎉 Done! Reload your shell: source ~/.bashrc"
