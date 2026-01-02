# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/bash/rc

# Add your own exports, aliases, and functions here.
#
# Make an alias for invoking commands you use constantly
# alias p='python'



alias readme='nvim ~/dotfiles/README.md'
alias dots='cd ~/dotfiles && git add . && git commit -m "Update $(date)" && git push && cd -'
alias pkm='cd ~/Documents/PKM && git pull && git add . && git commit -m "Update: $(date)" && git push && cd -'


up() {
    echo "🔄 Updating System..."
    sudo pacman -Syu --noconfirm

    echo "🧹 Cleaning Package Cache..."
    # Removes old versions of packages that are no longer installed
    sudo pacman -Sc --noconfirm
    
    # If you use yay, this cleans the AUR cache too
    if command -v yay &> /dev/null; then
        yay -Sc --noconfirm
    fi

    echo "📂 Syncing Dotfiles..."
    cd ~/dotfiles && git pull

    echo "📦 Updating VS Code Extensions..."
    ~/dotfiles/install.sh

    echo "✅ All systems updated and cleaned!"
    cd - > /dev/null
}

# --- CUSTOM STARTUP ---
if [[ $- == *i* ]]; then  # Only run in interactive sessions
    clear
    fastfetch --logo arch_small --color-keys blue --color-title cyan
    echo -e "Welcome back, Imad! 🚀 System is \e[32mReady\e[0m."
    echo -e "--------------------------------------------------\n"
fi
