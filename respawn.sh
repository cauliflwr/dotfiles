#!/bin/sh

# Modified / inspired by https://github.com/driesvints/dotfiles

echo "Let's go..."

# Check for Homebrew and install
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # For M1
  # echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zshrc
  # eval "$(/opt/homebrew/bin/brew shellenv)"
  
  # For Intel
  echo 'eval "$(/usr/local/bin/brew shellenv)"' >> $HOME/.zshrc
  eval "$(/usr/local/bin/brew shellenv)"
fi

# Symlink the .Brewfile
ln -s $HOME/Repos/dotfiles/.Brewfile $HOME/.Brewfile

# Update Homebrew recipes
brew update

# Install all dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle --file="$HOME/.Brewfile"

# Check for Oh My Zsh and install
if ! [ -d $HOME/.oh-my-zsh ]; then
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh) --unattended"
fi

# Install zsh-autosuggestions plugin
if ! [ -d $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

# Symlink the Mackup config file
ln -s $HOME/Repos/dotfiles/.mackup.cfg $HOME/.mackup.cfg

# Restore backed up configs
mackup restore

# Reinstall VSCode extensions
cat $HOME/.vscode/extensions/extensions.txt | xargs -L 1 code --install-extension

# Set MacOS preferences
source $HOME/Repos/dotfiles/macprefs.sh

echo "It's over!"