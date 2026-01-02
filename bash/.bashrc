# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source Omarchy defaults
source ~/.local/share/omarchy/default/bash/rc

# --- ALIASES ---
alias readme='nvim ~/dotfiles/README.md'
alias dots='cd ~/dotfiles && git add . && git commit -m "Update $(date)" && git push && cd -'
alias pkm='cd ~/Documents/PKM && git pull && git add . && git commit -m "Update: $(date)" && git push && cd -'
alias reload='source ~/.bashrc && echo "♻️ Shell Reloaded"'

# --- AUTOMATION FUNCTIONS ---

# Track a new config: track <name> <path>
track() {
    local folder_name=$1
    local target_path=$2

    if [ -z "$folder_name" ] || [ -z "$target_path" ]; then
        echo "Usage: track <package_name> <target_path>"
        echo "Example: track nvim ~/.config/nvim"
        return 1
    fi

    # Expand ~ to full path and convert back to $HOME for file portability
    target_path="${target_path/#\~/$HOME}"
    local portable_path="${target_path/#$HOME/\$HOME}"

    echo "📦 Tracking $folder_name at $target_path..."

    # Add to map.conf and create folder
    echo "$folder_name=$portable_path" >> ~/dotfiles/map.conf
    mkdir -p ~/dotfiles/"$folder_name"

    # Run up to finish the absorption and linking
    up
}

# The Master Update Function
up() {
    echo "🔄 Updating System..."
    sudo pacman -Syu --noconfirm

    echo "🧹 Cleaning Package Cache..."
    sudo pacman -Sc --noconfirm 2>/dev/null
    
    if command -v yay &> /dev/null; then
        yay -Sc --noconfirm 2>/dev/null
    fi

    echo "📂 Syncing Dotfiles..."
    cd ~/dotfiles && git pull --rebase

    # Run the installer
    ./install.sh
    
    cd - > /dev/null
    echo "✅ All systems updated and cleaned!"
}

# --- CUSTOM STARTUP (Welcome Screen) ---
clear
fastfetch --logo arch_small
echo -e "\nWelcome back, Imad! 🚀 System is \e[32mReady\e[0m."
echo -e "--------------------------------------------------\n"
