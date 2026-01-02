This README is designed to be the "Master Manual" for your system. It explains the high-level philosophy for any human and the technical implementation for any AI agent.

Copy this into your `~/dotfiles/README.md`:

---

# 🌌 Imad's Automated Arch System (Omarchy + Antigravity)

This repository is a **Self-Absorbing, Intelligent Configuration Management System**. It transforms a standard Arch Linux install (Omarchy) into a personalized, automated workstation.

## 🧠 System Philosophy

Unlike traditional dotfile repos that require manual copying, this system uses a **Dynamic Mapping Engine**. It detects local configurations, snapshots them for safety, absorbs them into the repository, and creates symbolic links—all with a single command.

---

## 🛠️ Core Architecture

### 1. The Dynamic Map (`map.conf`)

The "Brain" of the operation. It maps repository folder names to their real-world system paths.

* **Format:** `folder_name=$HOME/path/to/original`
* **Benefit:** Absolute portability. The same repo works regardless of your username or home directory path.

### 2. The Safety Vault (`~/config_backups`)

A professional-grade disaster recovery layer.

* **Action:** Before any file is moved or linked, the `install.sh` creates a timestamped snapshot in `~/config_backups`.
* **Retention:** Automatically prunes backups older than 30 days to save disk space.

### 3. The Absorption Engine (`install.sh`)

The "Heart" of the system. It processes the map using three-stage logic:

1. **Snapshot:** Backup existing data to the Safety Vault.
2. **Absorb:** If a local folder exists, merge its content into the repo and delete the local original.
3. **Link:** Use **GNU Stow** to create a symlink from the repo back to the system.

---

## 🚀 Key Workflows

### 🛠️ Daily Maintenance: `up`

Run this every morning or after making changes. It performs a full system lifecycle:

1. **Update:** Syncs Pacman and AUR (`yay`) packages.
2. **Clean:** Clears package caches to save space.
3. **Restore:** Runs `install.sh` to ensure all symlinks are healthy and new binaries (like Antigravity) are installed.
4. **Extensions:** Syncs extensions for both VS Code and Google Antigravity.

### ➕ Tracking New Configs: `track`

To start backing up a new program (e.g., `btop`):

```bash
track btop ~/.config/btop

```

This automatically updates `map.conf`, creates the folder structure, and triggers a system sync.

### ☁️ Cloud Sync: `dots`

Pushes your local configuration state to GitHub.

```bash
dots

```

*Note: Large binary files (caches, logs, and extension binaries) are automatically excluded via `.gitignore` to keep the repo under GitHub's 100MB limit.*

---

## 📦 Tracked Applications (Current)

| Module | Target Path | Description |
| --- | --- | --- |
| `hypr` | `~/.config/hypr` | Window Manager & UI Layout |
| `bash` | `~/.bashrc` | Shell logic, Aliases, & Automation |
| `antigravity` | `~/.gemini` | AI Agent Brain & Project Rules |
| `antigravity-settings` | `~/.antigravity` | IDE User Configs (Excludes Binaries) |
| `vscode` | `~/.config/Code/User` | Visual Studio Code Profile |
| `waybar` | `~/.config/waybar` | Status Bar Configuration |
| `ghostty` | `~/.config/ghostty` | GPU-Accelerated Terminal Config |
| `backgrounds` | `~/Pictures/Wallpapers` | System-wide Wallpapers |

---

## 🤖 AI / Developer Troubleshooting

### Broken Symlinks

If a config isn't loading, check if the link is broken:
`ls -l ~/.config/app_name`
If it points to a non-existent path, run `up` to re-establish the link.

### Portability Setup

To clone this system onto a brand new machine:

1. Install Arch/Omarchy.
2. `git clone https://github.com/imadvs/dotfiles.git ~/dotfiles`
3. `cd ~/dotfiles && ./install.sh`
4. The system will "re-install" your entire environment.

---

## 📝 Change Log

* **v1.0**: Initial Omarchy setup.
* **v1.1**: Added GNU Stow integration.
* **v1.2**: Implemented `map.conf` dynamic mapping.
* **v1.3**: Added Google Antigravity automated binary installation.
* **v2.0**: **Safety Vault Implementation** (Timestamped snapshots and auto-cleanup).

---

**Would you like me to create a "Quick Start" gist link for this README so you can share your setup easily?**
