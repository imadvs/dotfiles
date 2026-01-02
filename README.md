Here is the updated, clean version of your **README.md**. It now explains the **Dynamic Tracking** and **Omarchy foundation** so your documentation stays as professional as your code.

---

# 🌌 Imad's Dotfiles (Omarchy Powered)

A professional, fully automated Arch Linux environment built on the **Omarchy** framework. This system features dynamic configuration tracking, auto-absorption of local changes, and one-command maintenance.

---

## 🏗️ Framework & Tools

* **Base:** [Omarchy](https://www.google.com/search?q=https://github.com/omarchy) (Standardized shell environment).
* **Manager:** GNU Stow (Symlink farm manager).
* **Terminal:** Ghostty.
* **Shell:** Bash (Personalized with custom automation).

---

## 🚀 Key Features

* **Dynamic Tracking**: Use the `track` command to instantly add new programs to your dotfiles without manual file moving.
* **Auto-Absorb Logic**: The system detects "real" folders in `~/.config`, absorbs them into the repository, and replaces them with symlinks automatically.
* **Master Update (`up`)**: A single command that handles system upgrades, silent cache cleaning, git syncing, and configuration re-linking.
* **VS Code Sync**: Automates the installation of essential extensions and user settings.

---

## 🛠️ Custom Commands

| Command | Description |
| --- | --- |
| `up` | The master maintenance command. Updates system, cleans cache, and runs `install.sh`. |
| `track <name> <path>` | **New:** Automatically tracks a new config folder (e.g., `track nvim ~/.config/nvim`). |
| `dots` | Stages all changes, commits with a timestamp, and pushes to GitHub. |
| `pkm` | Syncs Personal Knowledge Management (PKM) vault via Git. |
| `reload` | Instantly applies changes made to `.bashrc`. |

---

## 📁 Mapping System

This repository uses `map.conf` to dynamically manage links. Current tracked paths include:

* `hypr` → `~/.config/hypr`
* `bash` → `~/.bashrc`
* `ghostty` → `~/.config/ghostty`
* `waybar` → `~/.config/waybar`
* `vscode` → `~/.config/Code/User/settings.json`

---

## 🖥️ System Status

| Component | Specification |
| --- | --- |
| **OS** | Arch Linux (Omarchy) |
| **Window Manager** | Hyprland |
| **Terminal** | Ghostty |
| **CPU** | [Insert CPU Model] |
| **GPU** | [Insert GPU Model] |

---

## 💻 Installation (New Machine)

1. **Clone:** `git clone https://github.com/[YOUR_USERNAME]/dotfiles.git ~/dotfiles`
2. **Install:** `cd ~/dotfiles && chmod +x install.sh && ./install.sh`
3. **Activate:** `source ~/.bashrc`

---

**Would you like me to help you fill in those CPU and GPU specs now so the README is 100% complete?**
