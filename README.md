Here is the updated, high-definition `README.md` for your repository. It now includes a **Change Log** at the end so you can track your system's evolution as you add more features.

---

# 🌌 Imad's Automated Arch System (Omarchy + Antigravity)

## 🚀 Quick Start (Fresh Install)

To mirror your workstation on a brand-new machine, run these three commands:

```bash
git clone https://github.com/imadvs/dotfiles.git ~/dotfiles
```

---

## 🧠 System Philosophy

This repository is a **Self-Absorbing Configuration Engine**. Instead of manual file management, the system dynamically detects local data, snapshots it for safety, and merges it into the cloud-synced repository automatically.

### The "Clean Home" Strategy

Unlike basic setups that clutter the `$HOME` directory with symlinks, this system is configured via `map.conf` to target specific configuration files (like `settings.json`). This keeps your Home folder clean while ensuring your IDE preferences are backed up without heavy extension binaries.

---

## 🛡️ The Safety Vault (`~/config_backups`)

To prevent data loss during sync or installation, the system takes a **snapshot** of your current files before moving or linking them.

* **Action:** Snapshotting occurs before absorption or linking.
* **Location:** `~/config_backups/[TIMESTAMP]`.
* **Retention:** The system automatically deletes backups older than 30 days to save disk space.

---

## 🛠️ User Commands (Workflow)

### 🔄 `up` (The Daily Sync)

A single command to keep the entire workstation healthy:

1. **System Update:** Syncs Pacman and AUR (`yay`) packages.
2. **App Restoration:** Ensures Brave, VS Code, and Antigravity binaries are installed.
3. **Extension Sync:** Force-installs the defined list of IDE extensions.
4. **Link Health:** Refreshes all GNU Stow symlinks.

### ➕ `track <name> <path>`

The primary tool for adding new applications to the backup cycle. It automatically updates `map.conf`, backups local data to the Vault, and establishes the symlink.

### ☁️ `dots`

The final step of the day: commits all changes and pushes your configuration state to GitHub.

---

## 📦 Core Architecture

### 1. The Dynamic Map (`map.conf`)

The database that tells the engine exactly where files belong. It supports both **folders** (for tools like Hyprland) and **individual files** (for IDE settings).

### 2. The Universal Installer (`install.sh`)

The "Heart" of the system. It is designed to be **Idempotent**, meaning it can be run multiple times without breaking anything.

* **Parent Directory Creation:** Automatically creates missing system paths (e.g., `~/.antigravity/User/`) so symlinks can be placed correctly on new installs.
* **Absorption Logic:** If it finds a real file where a link should be, it "absorbs" that data into the repository before linking.

---

## 📂 Tracked Modules (Optimized)

| Module | Target Path | Backup Type |
| --- | --- | --- |
| **hypr** | `~/.config/hypr` | Full Directory |
| **bash** | `~/.bashrc` | Individual File |
| **vscode-config** | `~/.config/Code/User/settings.json` | Settings Only |
| **antigravity-config** | `~/.antigravity/User/settings.json` | Settings Only |
| **ghostty** | `~/.config/ghostty` | Full Directory |
| **waybar** | `~/.config/waybar` | Full Directory |
| **backgrounds** | `~/Pictures/Wallpapers` | Media Folder |

---

## 🤖 AI / Developer Notes

* **Extensions:** Extensions are NOT backed up as files. They are restored via a list in `install.sh` to keep the repository lightweight.
* **Git Limits:** `.gitignore` is configured to prevent pushing binary models or large logs to GitHub.
* **Fresh Installs:** On new machines, `install.sh` handles the manual `curl` download and binary linking for Google Antigravity automatically.

---

## 📝 Change Log

* **v1.0 (Initial):** Basic Omarchy setup with manual symlinks.
* **v2.0 (The Engine):** Integrated `map.conf` for dynamic file and folder mapping.
* **v2.1 (Safety):** Implemented **The Safety Vault** for timestamped backups and auto-cleanup.
* **v2.2 (Optimized):** Migrated VS Code and Antigravity to "Settings Only" tracking to eliminate clutter and heavy binaries.

---

**Would you like me to help you create a specific `.gitignore` file now to make sure those heavy extension binaries never accidentally get uploaded?**
