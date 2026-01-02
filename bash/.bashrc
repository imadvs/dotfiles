# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source Omarchy defaults
source ~/.local/share/omarchy/default/bash/rc

# --- ALIASES ---
alias readme='nvim ~/dotfiles/README.md'
alias dots='cd ~/dotfiles && git add . && git commit -m "Update $(date)" && git push && cd -'
alias pkm='cd ~/Documents/PKM && git pull && git add . && git commit -m "Update: $(date)" && git push && cd -'

# --- THE MASTER UP FUNCTION ---
up() {
    echo "🔄 Updating System..."
    sudo pacman -Syu --noconfirm

    echo "🧹 Cleaning Package Cache..."
    # 2>/dev/null hides the "fd 7" errors you were seeing
    sudo pacman -Sc --noconfirm 2>/dev/null
    
    if command -v yay &> /dev/null; then
        yay -Sc --noconfirm
    fi

    echo "📂 Syncing Dotfiles..."
    # Using --rebase helps avoid "merge commit" mess in your history
    cd ~/dotfiles && git pull --rebase

    # This runs your installer which handles extensions and linking
    ./install.sh
    
    # Return to where you were
    cd - > /dev/null
    echo "✅ All systems updated and cleaned!"
}

# --- CUSTOM STARTUP (Welcome Screen) ---
clear
fastfetch --logo arch_small
echo -e "\nWelcome back, Imad! 🚀 System is \e[32mReady\e[0m."
echo -e "--------------------------------------------------\n"
