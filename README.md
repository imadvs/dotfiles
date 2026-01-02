Here is the complete, professional `README.md` for your repository. It combines the **Quick Start**, the **Safety Vault** logic, and the **Technical breakdown** so that any human or AI can manage your system.

---

# 🌌 Imad's Automated Arch System (Omarchy + Antigravity)

## 🚀 Quick Start (Fresh Install)

If you are on a new machine, run these three commands to mirror your workstation:

```bash
git clone https://github.com/imadvs/dotfiles.git ~/dotfiles
cd ~/dotfiles && ./install.sh
source ~/.bashrc

```

---

## 🧠 System Philosophy

This is a **Self-Absorbing Configuration Engine**. Instead of manual copying, the system detects local data, snapshots it for safety, and merges it into the cloud-synced repository automatically.

## 🛡️ The Safety Vault (`~/config_backups`)

To prevent data loss, every time you run the installer, the system takes a **snapshot** of your current files before moving or linking them.

* **Location:** `~/config_backups/[TIMESTAMP]`
* **Retention:** The system automatically deletes backups older than 30 days to save disk space.

---

## 🛠️ User Commands (Workflow)

### 🔄 `up` (The Daily Sync)

Updates system packages, cleans the cache, pulls latest dotfiles from GitHub, and ensures all symlinks are healthy.

### ➕ `track <name> <path>`

The most powerful tool in the arsenal. Use this to add a new app to your backup:

```bash
track ghostty ~/.config/ghostty

```

* **What it does:** Adds to `map.conf` → Backs up local data → Absorbs into repo → Symlinks back.

### ☁️ `dots`

A one-word command to commit and push all changes to your GitHub repository.

---

## 📦 Core Architecture

### 1. The Dynamic Map (`map.conf`)

The database that tells the engine where files belong.

* **Format:** `folder_name=$HOME/path/to/original`

### 2. The Engine (`install.sh`)

The automated script that handles:

* **Binary Installation:** (Brave, VS Code, Google Antigravity).
* **Extension Syncing:** Keeps VS Code and Antigravity extensions identical.
* **Stow Linking:** Uses GNU Stow to manage the `/home` directory.

---

## 📂 Tracked Modules

| Module | System Path | Description |
| --- | --- | --- |
| `hypr` | `~/.config/hypr` | Window Manager Configs |
| `bash` | `~/.bashrc` | Automation, Aliases, & Functions |
| `antigravity` | `~/.gemini` | AI Agent "Brain" & Rules |
| `antigravity-settings` | `~/.antigravity` | IDE Profile (Settings/Keybinds) |
| `vscode` | `~/.config/Code/User` | VS Code User Profile |
| `waybar` | `~/.config/waybar` | Desktop Status Bar |
| `ghostty` | `~/.config/ghostty` | Terminal Emulator Config |
| `backgrounds` | `~/Pictures/Wallpapers` | Desktop Wallpapers |

---

## 🤖 AI / Developer Troubleshooting

* **File Size Limits:** The `.gitignore` is configured to block large binary caches (ONNX models, `.so` files) to keep the GitHub repo under 100MB.
* **Manual Re-link:** If a config is missing, simply run `cd ~/dotfiles && ./install.sh`.
* **Idempotency:** All scripts are designed to be run multiple times without creating duplicate entries or breaking existing links.

---

### 🏁 Next Step

1. Open your `README.md` in your dotfiles folder.
2. Paste this entire block inside.
3. Run `dots` to finalize your repository.

**Is there anything else you'd like to include in the documentation, or are you ready to push this to GitHub?**
