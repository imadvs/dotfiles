# 🚀 Imad's Dotfiles

![Setup Preview](screenshot.png)

Personal configuration files for Omarchy OS (Arch-based Hyprland distribution).

## 🚀 Quick Setup (New Laptop)
```bash
# 1. Clone dotfiles
git clone git@github.com:imadvs/dotfiles.git ~/dotfiles

# 2. Install packages (OPTIONAL - can skip and do manually)
~/dotfiles/install-packages.sh

# 3. Setup configs
~/dotfiles/restore.sh

# 4. Done! Reload everything
source ~/.bashrc && hyprctl reload && nvim # Let LazyVim install plugins

```

## ✅ What Gets Restored

- **Bash** - Shell with custom aliases (dots, dotsc, track)
- **Hyprland** - Window manager with custom keybindings
- **Waybar** - Status bar
- **Ghostty** - Terminal emulator
- **Neovim** - LazyVim configuration
- **btop** - System monitor
- **walker** - App launcher
- **mako** - Notification daemon
- **IMAD Theme** - Custom red accent theme
- **Wallpapers** - 67 curated 4K images

## 📂 File Structure
```
dotfiles/
├── bash/              # Shell configuration
├── hypr/              # Hyprland WM
├── waybar/            # Status bar
├── ghostty/           # Terminal
├── nvim/              # Neovim (LazyVim)
├── backgrounds/       # 67 wallpapers
├── my-themes/IMAD/    # Custom theme
├── restore.sh         # Automated setup
├── test.sh            # Verify symlinks
└── PACKAGES.md        # Package list
└── install-packages.sh  # Install system packages
```

## 🎯 Custom Commands

- `dots` - Quick commit & push with timestamp
- `dotsc "message"` - Commit with custom message
- `readme` - Edit this README
- `track <name> <path>` - Track new config

## 🆘 Troubleshooting

### Theme not loading
```bash
cd ~/dotfiles/my-themes/IMAD
rm -f theme.conf && ln -sf hyprland.conf theme.conf
hyprctl reload
```

### Nvim theme broken
```bash
rm ~/.config/nvim/lua/plugins/theme.lua
ln -sf ~/dotfiles/my-themes/IMAD/neovim.lua ~/.config/nvim/lua/plugins/theme.lua
```

### Verify everything works
```bash
~/dotfiles/test.sh
```

## 🔐 SSH Setup (First Time)
```bash
ssh-keygen -t ed25519 -C "your_email@gmail.com"
cat ~/.ssh/id_ed25519.pub
# Add to: https://github.com/settings/keys
```

---

**Author:** Imad  
**Last Updated:** January 3, 2026  
**License:** Personal use - Feel free to fork!
