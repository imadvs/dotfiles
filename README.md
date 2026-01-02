# 🌌 Imad's Dotfiles (Omarchy Powered)

A professional, fully automated Arch Linux environment built on the **Omarchy** framework. This repository manages system updates, AUR packages, VS Code extensions, and hardware-aware configurations using **GNU Stow**.

---

## 🏗️ Framework & Tools

* **Base:** [Omarchy](https://www.google.com/search?q=https://github.com/omarchy) (Standardizing aliases and bash functions).
* **Manager:** GNU Stow (Symlink farm manager).
* **Terminal:** Ghostty.
* **Shell:** Bash (Extended via personalized `.bashrc`).

---

## 🚀 Key Features

* **Omarchy Integration**: Sources default Omarchy bash environments while adding custom logic.
* **Auto-Absorb Logic**: Local changes made in `~/.config` are automatically synced back to this repository during the update process.
* **One-Command Maintenance**: The `up` function handles system upgrades, silent cache cleaning, and config re-linking.
* **VS Code Sync**: Automates extension installation and `settings.json` management.

---

## 🛠️ Custom Commands

| Command | Description |
| --- | --- |
| `up` | Updates Pacman/AUR, cleans cache, pulls git changes, and runs `install.sh`. |
| `dots` | Stages all changes, commits with a timestamp, and pushes to GitHub. |
| `pkm` | Syncs Personal Knowledge Management (PKM) vault via Git. |
| `readme` | Quick shortcut to edit this documentation. |

---

## 📁 Mapping Structure

The `install.sh` uses the following `FOLDER_MAP` to ensure symlink accuracy:

* `ayaka` → `~/.config/ayaka`
* `hypr` → `~/.config/hypr`
* `bash` → `~/.bashrc` (Sources Omarchy defaults)
* `backgrounds` → `~/Pictures/Wallpapers`
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

## 💻 Installation

1. **Clone the repo:**
```bash
git clone https://github.com/[YOUR_USERNAME]/dotfiles.git ~/dotfiles

```


2. **Run the installer:**
```bash
cd ~/dotfiles
chmod +x install.sh
./install.sh

```


3. **Initialize Bash:**
```bash
source ~/.bashrc

```
