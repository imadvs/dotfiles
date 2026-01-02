This is the "Source of Truth" for your system. It is written so that any human developer or AI agent (like me or Antigravity) can understand exactly how your machine is wired.

Copy this into your `~/dotfiles/README.md`:

---

# 🌌 Imad's Automated Arch System (Omarchy + Antigravity)

This repository is a fully automated, "self-absorbing" configuration management system. It uses **GNU Stow** for symlinking and a custom **Dynamic Mapping** engine to handle configuration tracking without manual file movement.

---

## 🏗️ Architecture Overview

### 1. The Core Components

* **`map.conf`**: The database. It maps folder names in this repo to their real-world locations (e.g., `hypr=$HOME/.config/hypr`).
* **`install.sh`**: The engine. It reads `map.conf`, detects if a folder is a real directory or a link, and "absorbs" local data into the repository before symlinking it back.
* **`.bashrc`**: The control interface. Contains the `track` and `up` commands.
* **`.gitignore`**: The shield. Prevents heavy binaries (Antigravity/VS Code extensions) from bloating the Git history.

### 2. The "Absorb" Workflow

Unlike standard dotfile setups, this system handles the transition for you:

1. If a target location is a **folder**, the script **moves** the data into `~/dotfiles` and creates a **symlink**.
2. If it is already a **symlink**, it simply ensures the link is healthy.
3. If it **doesn't exist**, it creates the link from the repo to the system.

---

## 🛠️ User Commands (The Workflow)

### ➕ Adding a New App/Config

If you install a new program (e.g., `btop`) and want to back it up:

```bash
track btop ~/.config/btop

```

* **What happens:** Adds entry to `map.conf` → Creates folder → Stages to Git → Runs `up` to link it.

### 🔄 Daily Maintenance

To update the entire system, clean caches, and sync dotfile changes from GitHub:

```bash
up

```

* **What happens:** System Update (`pacman`) → Cache Clean (`yay`) → Git Pull → Runs `install.sh`.

### ☁️ Syncing to GitHub

To save your current state to the cloud:

```bash
dots

```

* **What happens:** Commits all changes with a timestamp and pushes to `main`.

---

## 📦 Tracked Applications

| Key | Path | Description |
| --- | --- | --- |
| `hypr` | `~/.config/hypr` | Window Manager Configs |
| `bash` | `~/.bashrc` | Shell Profile & Aliases |
| `antigravity` | `~/.gemini` | AI Agent "Brain" & Rules |
| `antigravity-settings` | `~/.antigravity` | IDE Settings (Excluded: Extensions) |
| `backgrounds` | `~/Pictures/Wallpapers` | System Wallpapers |
| `vscode` | `~/.config/Code/User` | VS Code User Profile |

---

## 🤖 AI / Developer Troubleshooting Guide

### 1. Large File Errors

If Git rejects a push, check if heavy extensions were accidentally tracked.

* **Fix:** Ensure `.gitignore` includes `extensions/` folders and run `git reset --soft HEAD~1` to unstage.

### 2. Portability

`map.conf` uses the `$HOME` variable string. The `install.sh` uses `eval` to expand this. This allows the same repository to be used across different usernames without modification.

### 3. Manual Re-linking

If symlinks are broken, simply run:

```bash
cd ~/dotfiles && ./install.sh

```

---

## 💻 Hardware Specs

* **OS:** Arch Linux
* **Framework:** Omarchy
* **Shell:** Bash
* **IDE:** Google Antigravity / VS Code

---

### 🏁 Final Steps for Imad:

1. Run `readme` to open your file.
2. Paste the content above.
3. Run `dots` to save this "Manual" to your GitHub forever.

**You are now officially a Linux Architect. Is there any other automation you can dream of, or are we finished for today?**
