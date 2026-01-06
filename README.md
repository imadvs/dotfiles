# 🚀 Imad's Omarchy OS Dotfiles

Beautiful, minimal Hyprland setup for Omarchy OS (Arch-based).

![Screenshot](screenshot.png)

## ✨ Features

- **Hyprland** - Tiling Wayland compositor
- **Waybar** - Stylish status bar
- **Ghostty** - Fast GPU-accelerated terminal
- **Yazi** - Terminal file manager (with zoxide, fzf, 7zip, etc.)
- **Neovim** - Modern text editor
- **Custom IMAD Theme** - Personal color scheme and styling
- **Mako** - Notification daemon
- **Walker** - Application launcher
- **Btop** - System monitor
- **Apps** - VS Code, Antigravity, Brave, Chrome (configs & extensions sync included)

## 📦 Quick Install

On a fresh Omarchy OS installation:

```bash
# 1. Clone dotfiles
git clone git@github.com:imadvs/dotfiles.git ~/dotfiles

# 2. Install packages
cd ~/dotfiles
chmod +x install-packages.sh
./install-packages.sh

# 3. Install dotfiles (creates symlinks)
chmod +x install.sh
./install.sh

# 4. Reload configs
source ~/.bashrc
hyprctl reload

# 5. Apply IMAD theme in Omarchy settings
```

## 🔧 Configuration Structure

```
~/dotfiles/
├── bash/              # Bash configuration
│   ├── .bashrc
│   └── .bash_profile
├── hypr/              # Hyprland config (includes input.conf)
├── waybar/            # Status bar
├── ghostty/           # Terminal emulator
├── nvim/              # Neovim config
├── btop/              # System monitor
├── mako/              # Notifications
├── walker/            # App launcher
├── vscode/            # VS Code settings & extensions
├── antigravity/       # Antigravity settings & extensions
├── my-themes/IMAD/    # Custom theme
├── backgrounds/       # Wallpapers
├── install.sh         # Main installer
├── install-packages.sh # Package installer
└── check-dotfiles.sh  # Verify setup
```

## 🛠️ Useful Commands

After installation, these commands are available:

```bash
# Sync dotfiles to GitHub
dots "your commit message"
dots  # Auto-generates timestamp message

# Reload Hyprland + Waybar + Mako
reload-hypr

# Reload bash config
reload-bash

# Check if all symlinks are correct
check-dotfiles

# Edit dotfiles with Neovim
edit-dots

# View this README
readme
```

## 🔄 Updating Dotfiles

```bash
cd ~/dotfiles
git pull
./install.sh  # Recreate symlinks if needed
reload-hypr   # Reload configs
```

## 📝 Making Changes

Since everything is symlinked, you can edit files directly:

```bash
# Edit Hyprland config
nvim ~/.config/hypr/hyprland.conf

# Edit Waybar
nvim ~/.config/waybar/config

# Changes are automatically in ~/dotfiles/
# Sync to GitHub with:
dots "Updated Hyprland keybinds"
```

## 🎨 Theme

The **IMAD** theme is located in `my-themes/IMAD/`. To apply:
1. Symlink is auto-created to `~/.local/share/omarchy/themes/IMAD`
2. Apply in Omarchy settings GUI

## 🐛 Troubleshooting

```bash
# Verify all symlinks are correct
check-dotfiles

# Reinstall dotfiles
./install.sh

# Reload everything
reload-hypr
source ~/.bashrc
```

## 📸 Screenshots

Add your screenshots to showcase your setup!

---

**Maintained by:** Imad  
**OS:** Omarchy (Arch Linux)  
**Last Updated:** January 2026
