#!/usr/bin/env bash

# Modified from https://github.com/mathiasbynens/dotfiles and
# https://github.com/driesvints/dotfiles

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# General UI/UX                                                               #
###############################################################################

# Set computer name (as done via System Preferences → Sharing)
sudo scutil --set ComputerName "ambrosia"
sudo scutil --set HostName "ambrosia"
sudo scutil --set LocalHostName "ambrosia"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "ambrosia"

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

echo "Done. Note that some of these changes require a logout/restart to take effect."