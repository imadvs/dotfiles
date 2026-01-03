# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source Omarchy defaults
source ~/.local/share/omarchy/default/bash/rc

# --- ALIASES ---
alias readme='nvim ~/dotfiles/README.md'
alias dots='cd ~/dotfiles && git add . && git commit -m "Update $(date +"%a %b %d %I:%M %p %Y")" && git push && cd -'

# Quick push with custom message: dots "your message here"
dotsc() {
    cd ~/dotfiles && git add . && git commit -m "$*" && git push && cd -
}

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
    
    target_path="${target_path/#\~/$HOME}"
    local portable_path="${target_path/#$HOME/\$HOME}"
    
    echo "📦 Tracking $folder_name at $target_path..."
    echo "$folder_name=$portable_path" >> ~/dotfiles/map.conf
    mkdir -p ~/dotfiles/"$folder_name"
}

# --- CUSTOM STARTUP ---
clear
fastfetch --logo arch_small
echo -e "\nWelcome back, Imad! 🚀 System is \e[32mReady\e[0m."
echo -e "--------------------------------------------------\n"
