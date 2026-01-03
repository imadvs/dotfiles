# Dotfiles Restoration Guide

## Quick Start (New System)
```bash
# 1. Clone the repo & Run restore script
git clone git@github.com:imadvs/dotfiles.git ~/dotfiles
~/dotfiles/restore.sh

# 3. Install required packages
sudo pacman -S hyprland waybar git
yay -S ghostty

# 4. Apply configs
source ~/.bashrc
hyprctl reload
```

## What Gets Restored

- ✅ Bash configs (.bashrc, .bash_profile)
- ✅ Hyprland configuration
- ✅ Waybar status bar
- ✅ Ghostty terminal
- ✅ Custom IMAD theme
- ✅ Wallpapers

## Manual Fixes

If theme doesn't load:
```bash
cd ~/dotfiles/my-themes/IMAD
rm theme.conf
ln -sf hyprland.conf theme.conf
hyprctl reload
```

## File Structure
```
dotfiles/
├── bash/           → ~/.bashrc, ~/.bash_profile
├── hypr/           → ~/.config/hypr/
├── waybar/         → ~/.config/waybar/
├── ghostty/        → ~/.config/ghostty/
├── backgrounds/    → ~/Pictures/Wallpapers/
├── my-themes/IMAD/ → ~/.config/omarchy/themes/imadtheme/
├── restore.sh      → Restoration script
└── map.conf        → Symlink mappings
```
