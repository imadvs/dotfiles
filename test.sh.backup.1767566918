#!/bin/bash
# Quick test to verify all symlinks are working

echo "🔍 Testing dotfiles setup..."
echo ""

PASS="\033[0;32m✓\033[0m"
FAIL="\033[0;31m✗\033[0m"

check_link() {
    if [ -L "$1" ]; then
        echo -e "$PASS $1"
    else
        echo -e "$FAIL $1 (missing or not a symlink)"
    fi
}

echo "System symlinks:"
check_link ~/.bashrc
check_link ~/.bash_profile
check_link ~/.config/hypr
check_link ~/.config/ghostty
check_link ~/.config/waybar
check_link ~/.config/nvim
check_link ~/Pictures/Wallpapers
check_link ~/.config/omarchy/themes/imadtheme
check_link ~/.config/btop
check_link ~/.config/walker
check_link ~/.config/mako

echo ""
echo "Internal symlinks:"
check_link ~/dotfiles/my-themes/IMAD/theme.conf
check_link ~/dotfiles/nvim/lua/plugins/theme.lua

echo ""
echo "✅ Test complete!"
