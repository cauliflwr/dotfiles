#!/bin/zsh

# Modified from and inspired by:
# - https://github.com/driesvints/dotfiles
# - https://github.com/techdufus/dotfiles

# color codes
RESTORE='\033[0m'
NC='\033[0m'
BLACK='\033[00;30m'
RED='\033[00;31m'
GREEN='\033[00;32m'
YELLOW='\033[00;33m'
BLUE='\033[00;34m'
PURPLE='\033[00;35m'
CYAN='\033[00;36m'
SEA="\\033[38;5;49m"
LIGHTGRAY='\033[00;37m'
LBLACK='\033[01;30m'
LRED='\033[01;31m'
LGREEN='\033[01;32m'
LYELLOW='\033[01;33m'
LBLUE='\033[01;34m'
LPURPLE='\033[01;35m'
LCYAN='\033[01;36m'
WHITE='\033[01;37m'
OVERWRITE='\e[1A\e[K'

#emoji codes
CHECK_MARK="${GREEN}\xE2\x9C\x94${NC}"
X_MARK="${RED}\xE2\x9C\x96${NC}"
PIN="${RED}\xF0\x9F\x93\x8C${NC}"
CLOCK="${GREEN}\xE2\x8C\x9B${NC}"
ARROW="${SEA}\xE2\x96\xB6${NC}"
BOOK="${RED}\xF0\x9F\x93\x8B${NC}"
HOT="${ORANGE}\xF0\x9F\x94\xA5${NC}"
WARNING="${RED}\xF0\x9F\x9A\xA8${NC}"
RIGHT_ANGLE="${GREEN}\xE2\x88\x9F${NC}"

echo ""
if read -q "RES?ARe you ready to get started? [N/n]: "; then
    echo "\n${HOT}${HOT} Let's go! ${HOT}${HOT}"
    echo "Starting resurrect and refresh..."
else
    echo "${X_MARK}${X_MARK} Exiting. ${X_MARK}${X_MARK}"
    exit 0
fi


# Check for and install Homebrew
echo "Verifying that Homebrew is installed..."
if [[ $(which brew) == "brew not found" ]]; then
    
    # Intall Homebrew
    echo "It is not, installing..."
    #/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew install location to shell
    if [[ $(machine) =~ arm64* ]]; then
        # For Apple silicon
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zshrc
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        # For Intel
        echo 'eval "$(/usr/local/bin/brew shellenv)"' >> $HOME/.zshrc
        eval "$(/usr/local/bin/brew shellenv)"
    fi
    echo "Done."
else
    echo "It is. ${CHECK_MARK}"
fi

# Update Homebrew recipes
brew update

# Install core Homebrew managed dependencies with bundle
echo ""
echo "Installling core Homebrew managed dependencies..."
brew tap homebrew/bundle
brew bundle --file="./.Brewfile"

# Install watchdog for use with beautiful_output
python3 -m pip install -U watchdog --break-system-packages

# Complete setup with Ansible
echo "Preparing to complete setup with Ansible..."
ansible-playbook "./respawn.yml" 
