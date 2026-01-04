# 🚀 Imad's Dotfiles

![Setup Preview](screenshot.png)

> My personal Arch Linux (Omarchy OS) configuration with Hyprland, featuring a custom red-accent theme and automated setup.

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

## ✨ Features

- 🎨 **Custom IMAD Theme** - Red accent colors across all applications
- ⚡ **One-command Setup** - Fully automated installation
- 🪟 **Hyprland** - Modern tiling Wayland compositor
- 📊 **Complete System** - Terminal, editor, status bar, launcher, notifications
- 🖼️ **67 Curated Wallpapers** - 4K anime & tech themed
- ✅ **Tested & Verified** - Health check script included

## 🚀 Quick Setup
```bash
# 1. Clone the repository
git clone https://github.com/imadvs/dotfiles.git ~/dotfiles

# 2. Install packages (optional - automated)
~/dotfiles/install-packages.sh

# 3. Setup configs
~/dotfiles/restore.sh

# 4. Reload everything
source ~/.bashrc
hyprctl reload
```

## 📦 What's Included

| Component | Description |
|-----------|-------------|
| **Hyprland** | Wayland compositor with custom keybindings |
| **Waybar** | Status bar with custom styling |
| **Ghostty** | Fast GPU-accelerated terminal |
| **Neovim** | LazyVim configuration with custom theme |
| **btop** | System monitor with custom colors |
| **walker** | App launcher with theme integration |
| **mako** | Notification daemon |
| **IMAD Theme** | Consistent red-accent theme across all apps |

## 🎨 Theme Preview

**Colors:**
- Background: `#262626`
- Foreground: `#e6e6e6`
- Accent: `#e65c5c` (Red)
- Borders: 10px rounded with red active borders
- Transparency: Blur effects enabled

## 📂 Structure
```
dotfiles/
├── bash/              # Shell configuration
├── hypr/              # Hyprland window manager
├── waybar/            # Status bar
├── ghostty/           # Terminal
├── nvim/              # Neovim (LazyVim)
├── btop/              # System monitor
├── walker/            # App launcher
├── mako/              # Notifications
├── backgrounds/       # Wallpapers (67 images)
├── my-themes/IMAD/    # Custom theme
├── install-packages.sh # Package installer
├── restore.sh         # Config setup
└── test.sh            # Health check
```

## 🎯 Custom Features

### Bash Aliases
- `dots` - Quick commit and push with timestamp
- `dotsc "msg"` - Commit with custom message
- `readme` - Edit README
- `track <name> <path>` - Track new config

### Hyprland Keybindings
- `SUPER + Enter` - Launch terminal
- `SUPER + Q` - Close window
- `CTRL + SHIFT + [1-9]` - Switch group tabs
- `SUPER + CTRL + G` - Toggle window grouping
- See `hypr/bindings.conf` for full list

## 🔧 Requirements

- **OS:** Arch Linux / Omarchy OS
- **Display Server:** Wayland
- **Dependencies:** See [PACKAGES.md](PACKAGES.md)

## 🆘 Troubleshooting

### Verify Setup
```bash
~/dotfiles/test.sh
```

### Theme Not Loading
```bash
cd ~/dotfiles/my-themes/IMAD
rm -f theme.conf && ln -sf hyprland.conf theme.conf
hyprctl reload
```

### Neovim Theme Issues
```bash
rm ~/.config/nvim/lua/plugins/theme.lua
ln -sf ~/dotfiles/my-themes/IMAD/neovim.lua ~/.config/nvim/lua/plugins/theme.lua
```

## 📸 Screenshots

*Add more screenshots here if you want*

## 🤝 Contributing

Feel free to fork and customize for your own setup! If you find improvements, PRs are welcome.

## 📜 License

MIT License - Feel free to use and modify!

## 🙏 Acknowledgments

- [Omarchy OS](https://omarchy.org) - Base distribution
- [Hyprland](https://hyprland.org) - Window manager
- [LazyVim](https://www.lazyvim.org) - Neovim config

---

**⭐ If you found this useful, consider giving it a star!**

Made with ❤️ by [Imad](https://github.com/imadvs)
