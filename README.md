This README will guide you through restoring your entire environment on a brand-new computer using the dotfiles system we just perfected.
🚀 Restoring My Dotfiles
This repository contains my personal configurations (Hyprland, Waybar, Alacritty, and Omarchy Themes). It uses GNU Stow to manage symbolic links, ensuring that any changes made in the system are automatically tracked here.
🛠️ 1. Prerequisites
Before starting, ensure you have the necessary tools installed on your new Linux distribution:
 * Git: To clone the repository.
 * GNU Stow: To create the symlinks.
 * GitHub CLI (gh): For authentication.
<!-- end list -->
# Example for Arch Linux
sudo pacman -S git stow github-cli

📥 2. Clone the Repository
Clone your dotfiles into your home directory. It must be named dotfiles for the scripts to work correctly.
cd ~
git clone https://github.com/imadvs/dotfiles.git
cd dotfiles

🔗 3. The "Stow" Magic (Linking)
Instead of copying files, we create "bridges" (symbolic links). This makes the folders in ~/.config point directly to your ~/dotfiles folder.
# Link the Hyprland config
stow hypr

# Link the Ayaka theme (including custom wallpapers)
stow ayaka

> Note: If you get a "conflict" error, it means a real folder already exists in ~/.config. Delete that folder first (rm -rf ~/.config/folder_name) and run the stow command again.
> 
🖼️ 4. Verify the Setup
Once stowed, your theme folder should show the "link" icon (the arrow). You can verify this in the terminal:
ls -la ~/.config/omarchy/themes/

 * Correct Output: ayaka -> /home/imad/dotfiles/ayaka/...
🔄 5. Daily Usage & Backups
To save new changes (like adding a wallpaper or changing a keybinding) to GitHub, simply use the custom dots command we set up:
dots

Adding a new Theme
 * Create a folder for it in ~/dotfiles/.
 * Move the theme files from ~/.config/omarchy/themes/ into that new folder.
 * Run stow <theme-name> to link it back.
✅ Finished!
Your computer is now synced. Any wallpaper added to ~/dotfiles/ayaka/.config/omarchy/themes/ayaka/backgrounds/ will now automatically appear in your laptop's theme picker.
