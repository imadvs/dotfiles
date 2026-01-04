#!/bin/bash

echo "🔍 Checking Omarchy Dotfiles Setup..."
echo ""

DOTFILES_DIR="$HOME/dotfiles"
all_good=true

check_symlink() {
    local target=$1
    local link=$2
    local name=$3
    
    if [ -L "$link" ]; then
        actual_target=$(readlink -f "$link")
        expected_target=$(readlink -f "$target")
        
        if [ "$actual_target" = "$expected_target" ]; then
            echo "✅ $name"
        else
            echo "⚠️  $name (points to wrong location)"
            echo "   Expected: $expected_target"
            echo "   Actual: $actual_target"
            all_good=false
        fi
    else
        echo "❌ $name (not a symlink or doesn't exist)"
        all_good=false
    fi
}

check_file_exists() {
    local file=$1
    local name=$2
    
    if [ -f "$file" ]; then
        echo "✅ $name"
    else
        echo "❌ $name (file not found)"
        all_good=false
    fi
}

echo "📂 Checking symlinks..."
check_symlink "$DOTFILES_DIR/bash/.bashrc" ~/.bashrc "Bash RC"
check_symlink "$DOTFILES_DIR/bash/.bash_profile" ~/.bash_profile "Bash Profile"
check_symlink "$DOTFILES_DIR/hypr" ~/.config/hypr "Hyprland"
check_symlink "$DOTFILES_DIR/waybar" ~/.config/waybar "Waybar"
check_symlink "$DOTFILES_DIR/ghostty" ~/.config/ghostty "Ghostty"
check_symlink "$DOTFILES_DIR/nvim" ~/.config/nvim "Neovim"
check_symlink "$DOTFILES_DIR/btop" ~/.config/btop "Btop"
check_symlink "$DOTFILES_DIR/walker" ~/.config/walker "Walker"
check_symlink "$DOTFILES_DIR/mako" ~/.config/mako "Mako"
check_symlink "$DOTFILES_DIR/backgrounds" ~/Pictures/Wallpapers "Wallpapers"

echo ""
echo "📋 Checking important files..."
check_file_exists "$DOTFILES_DIR/hypr/hyprland.conf" "Hyprland config"
check_file_exists "$DOTFILES_DIR/bash/.bashrc" "Bashrc"

echo ""
echo "🔧 Checking required commands..."
commands=("hyprctl" "waybar" "nvim" "git" "fastfetch" "btop" "ghostty")
for cmd in "${commands[@]}"; do
    if command -v "$cmd" &> /dev/null; then
        echo "✅ $cmd"
    else
        echo "❌ $cmd (not installed)"
        all_good=false
    fi
done

echo ""
if [ "$all_good" = true ]; then
    echo "🎉 Everything looks good!"
else
    echo "⚠️  Some issues found. Run 'install.sh' to fix them."
fi
echo ""
