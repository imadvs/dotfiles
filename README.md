# 🚀 Restoring My Dotfiles

This repository contains my personal configurations (Hyprland, Waybar, Alacritty, and Omarchy Themes). It uses **GNU Stow** to manage symbolic links, ensuring that any changes made in the system are automatically tracked here.

---

## ⚡ 1. Fast Track (Automatic Setup)
If you are on a fresh Arch Linux install, run this single command to update your system, install your apps (Brave, VS Code, etc.), and link all your configs:

```bash
git clone [https://github.com/imadvs/dotfiles.git](https://github.com/imadvs/dotfiles.git) ~/dotfiles && cd ~/dotfiles && chmod +x install.sh && ./install.sh

```

---

## 🛠️ 2. Prerequisites

If you prefer to do things manually, ensure you have these tools first:

```bash
# Example for Arch Linux
sudo pacman -S git stow github-cli

```

---

## 🔗 3. The "Stow" Magic (Linking)

Instead of copying files, we create "bridges" (symbolic links). This makes the folders in `~/.config` point directly to your `~/dotfiles` folder.

```bash
# To link everything at once:
cd ~/dotfiles
stow */

```

> [!TIP]
> **No more conflict errors!** My `install.sh` script now automatically detects and removes real folders in `~/.config` or `~/` that would cause a stow conflict, making the restoration process hands-free.

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

## 🖼️ 5. Wallpapers & Assets

I keep my wallpapers organized in two places:

1. **Theme Assets**: Located in `ayaka/` for the Omarchy theme picker.
2. **Personal Vault**: Located in `backgrounds/` which links to `~/Pictures/Wallpapers`.

To verify your links are active, run:

```bash
ls -la ~/.config | grep "->"

```

---

## ✅ Finished!

Your computer is now synced. Any wallpaper added to your dotfiles will be tracked, and your `install.sh` ensures you can recreate this exact environment on any machine in minutes.

```

### Next Step:
Now that your README is updated, run your backup command one last time to push the new documentation and your finalized `install.sh` to GitHub:

```bash
dots

```

**Would you like me to show you how to add your VS Code extensions to the `install.sh` so your coding environment also restores itself automatically?**
