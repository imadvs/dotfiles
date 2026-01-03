#!/bin/bash
DOT_DIR="$HOME/dotfiles"
CONF_DIR="$HOME/.config"

link_item() {
    local name=$1
    echo "🔗 Linking $name..."
    rm -rf "$CONF_DIR/$name"
    ln -s "$DOT_DIR/$name" "$CONF_DIR/$name"
}

mkdir -p "$CONF_DIR"
link_item "hypr"
link_item "omarchy"
echo "✅ Done! Reloading..."
hyprctl reload
