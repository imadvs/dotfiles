# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source Omarchy defaults
source ~/.local/share/omarchy/default/bash/rc

# --- ALIASES ---
alias readme='nvim ~/dotfiles/README.md'
alias dots='cd ~/dotfiles && git add . && git commit -m "Update $(date)" && git push && cd -'
alias pkm='cd ~/Documents/PKM && git pull && git add . && git commit -m "Update: $(date)" && git push && cd -'
alias reload='source ~/.bashrc && echo "♻️ Shell Reloaded"'


# --- THE MASTER UP FUNCTION ---
up() {
    echo "🔄 Updating System..."
    sudo pacman -Syu --noconfirm

    echo "🧹 Cleaning Package Cache..."
    # This specifically silences the fd 7 errors and handles the Y/n prompts automatically
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
