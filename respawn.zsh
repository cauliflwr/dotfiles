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

RESURRECT=""

# Check for and install Homebrew
checkForHomebrew() {
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
        echo "${CHECK_MARK} It is."
    fi
}

main() {
    echo ""
    echo "\n${HOT} Let's go!"

    # Check for Homebrew on resurrect
    if [[ $RESURRECT = true ]]; then
        echo ""
        echo "Starting resurrect..."    
        checkForHomebrew

        # Use bundle to make sure core Homebrew managed dependencies are installed
        echo "Installling core Homebrew managed dependencies..."
        brew tap homebrew/bundle
        brew bundle --file="./.Brewfile"

        # Install watchdog for use with beautiful_output.py
        echo "Installing watchdog..."
        python3 -m pip install -U watchdog --break-system-packages
        
        echo ""
        echo "${CHECK_MARK} Resurrect complete."
    fi

    # Respawn
    echo ""
    echo "Starting respawn with Ansible..."
    ansible-playbook "./respawn.yml" --tags "personal"

    echo ""
    echo "${CHECK_MARK} Respawn complete."
}


##### Begin #####
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --resurrect) RESURRECT=true
            shift;;
        --respawn) RESURRECT=false
            shift;;
        *) echo "Unknown parameter: $1"
            exit 1;;
    esac
done

if [[ $RESURRECT == "" ]]; then
    echo ""
    echo "Would you like to resurrect or respawn?"
    vared -p "[r]esurrect, [re]spawn, or [e]exit (default: [e]xit): " -c RES
    #if read -q "RES?Preparing to rebuild your macOS config, are you ready to get started y/[n]? "; then
    case $RES in
        r) RESURRECT=true
            ;;
        re) RESURRECT=false
            ;;
        e) echo "\n${X_MARK} Exiting."
            exit 0;;
        *) echo "Unknown option: $RES"
            exit 1;;
    esac
fi

# Run main
main
exit 0
