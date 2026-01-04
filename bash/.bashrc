# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source Omarchy defaults
source ~/.local/share/omarchy/default/bash/rc

# --- ALIASES ---
alias readme='nvim ~/dotfiles/README.md'

# All-in-one dotfiles sync
dots() {
    local msg="${*:-Update $(date +'%a %b %d %I:%M %p %Y')}"
    cd ~/dotfiles || return
    git add .
    git commit -m "$msg"
    git push
    cd - > /dev/null
}

# --- CUSTOM STARTUP ---
clear
fastfetch --logo arch_small
echo -e "\nWelcome back, Imad! 🚀 System is \e[32mReady\e[0m."
echo -e "--------------------------------------------------\n"
export PATH="$HOME/.local/bin:$PATH"
