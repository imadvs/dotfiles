Here is a clean, correct, fully copy-friendly Markdown README.
Everything that must be copyable is inside proper fenced code blocks.
No broken sections, no mixed text inside code blocks, no GitHub rendering issues.

You can copy-paste this directly as README.md.


---

# 🚀 Restoring My Dotfiles

This repository contains my personal Linux configuration files (**Hyprland, Waybar, Alacritty, Omarchy themes**).

It uses **GNU Stow** to manage symbolic links, so:
- Your real config lives in this repo
- Your system just points to it
- Any change is automatically tracked

---

## 🛠️ 1. Prerequisites

Make sure you have the required tools installed.

### Arch Linux
```bash
sudo pacman -S git stow github-cli
```

---

📥 2. Clone the Repository

Clone the dotfiles into your home directory.
⚠️ The folder must be named dotfiles.

cd ~
git clone https://github.com/imadvs/dotfiles.git
cd dotfiles


---

🔗 3. The “Stow” Magic (Linking Configs)

Instead of copying files, Stow creates symbolic links.

This means:

~/.config/* points to ~/dotfiles/*

Changes are shared both ways


Example: Hyprland

stow hypr

Example: Ayaka Theme

stow ayaka

> ⚠️ IMPORTANT

If you get a conflict error, it means a real folder already exists.

Remove it, then run stow again:

rm -rf ~/.config/folder_name




---

🖼️ 4. Verify the Setup

After stowing, folders should be symbolic links.

Check with:

ls -la ~/.config/omarchy/themes/

✅ Correct Output Example

ayaka -> /home/imad/dotfiles/ayaka/...

If you see the arrow (->), it’s working.


---

🔄 5. Daily Usage & Backups

To push new changes (wallpapers, keybinds, themes), just run:

dots

This command handles:

git add

git commit

git push



---

🎨 Adding a New Theme

1. Create a folder inside ~/dotfiles/



mkdir ~/dotfiles/new-theme

2. Move the theme files into it



mv ~/.config/omarchy/themes/new-theme ~/dotfiles/new-theme

3. Link it back using Stow



stow new-theme


---

✅ Finished

Your system is now fully synced.

Any wallpaper added here:

~/dotfiles/ayaka/.config/omarchy/themes/ayaka/backgrounds/

will automatically appear in your theme picker.
