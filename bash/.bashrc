# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source Omarchy defaults (if they exist)
if [ -f ~/.local/share/omarchy/default/bash/rc ]; then
    source ~/.local/share/omarchy/default/bash/rc
fi

# --- ALIASES ---
alias readme='nvim ~/dotfiles/README.md'
alias dots-check='~/dotfiles/check-dotfiles.sh'

# --- DOTFILES MANAGEMENT ---

# All-in-one dotfiles sync to GitHub
dots() {
    local msg="${*:-Update $(date +'%a %b %d %I:%M %p %Y')}"
    cd ~/dotfiles || return
    git add .
    git commit -m "$msg"
    git push
    cd - > /dev/null
    echo "✅ Dotfiles synced to GitHub!"
}

# Reload Hyprland and related configs
reload-hypr() {
    echo "🔄 Reloading Hyprland configs..."
    hyprctl reload
    killall waybar 2>/dev/null && waybar &
    killall mako 2>/dev/null && mako &
    echo "✅ Hyprland configs reloaded!"
}

# Reload bash config
reload-bash() {
    source ~/.bashrc
    echo "✅ Bash config reloaded!"
}

# Quick edit dotfiles
edit-dots() {
    cd ~/dotfiles
    nvim .
}

# --- CUSTOM STARTUP ---
clear
fastfetch --logo arch_small
echo -e "\nWelcome back, Imad! 🚀 System is \e[32mReady\e[0m."
echo -e "--------------------------------------------------\n"
