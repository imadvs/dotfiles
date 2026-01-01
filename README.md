# 🚀 Restoring My Dotfiles

This repository contains my personal configurations (Hyprland, Waybar, Alacritty, and Omarchy Themes). It uses **GNU Stow** to manage symbolic links, ensuring that any changes made in the system are automatically tracked here.

---

## 🛠️ 1. Prerequisites
Before starting, ensure you have the necessary tools installed on your new Linux distribution:

```bash
# Example for Arch Linux
sudo pacman -S git stow github-cli

```

---

## 📥 2. Clone the Repository

Clone your dotfiles into your home directory. It **must** be named `dotfiles` for the scripts to work correctly.

```bash
cd ~
git clone [https://github.com/imadvs/dotfiles.git](https://github.com/imadvs/dotfiles.git)
cd dotfiles

```

---

## 🔗 3. The "Stow" Magic (Linking)

Instead of copying files, we create "bridges" (symbolic links). This makes the folders in `~/.config` point directly to your `~/dotfiles` folder.

```bash
# Link the Hyprland config
stow hypr

# Link the Ayaka theme (including custom wallpapers)
stow ayaka

```

> [!IMPORTANT]
> If you get a "conflict" error, it means a real folder already exists in `~/.config`. Delete that folder first (`rm -rf ~/.config/folder_name`) and run the `stow` command again.

---

## 📜 4. Custom Scripts & Shortcuts

### The `dots` Command

To make life easier, I use a custom script called `dots` to handle backups. It automates:

1. **Adding** all new changes (new wallpapers, tweaks).
2. **Committing** with an automatic timestamp.
3. **Pushing** everything to GitHub.

```bash
# To backup now:
dots

```

### The `readme` Shortcut

I've added an alias to my shell so I can view these instructions instantly:

```bash
# To open this file in Neovim:
readme

```

---

## 🖼️ 5. Verify the Setup

Once stowed, your theme folder should show the "link" icon (the arrow). You can verify this in the terminal:

```bash
ls -la ~/.config/omarchy/themes/

```

* **Correct Output:** `ayaka -> /home/imad/dotfiles/ayaka/...`

---

## ✅ Finished!

Your computer is now synced. Any wallpaper added to `~/dotfiles/ayaka/.config/omarchy/themes/ayaka/backgrounds/` will now automatically appear in your laptop's theme picker.
