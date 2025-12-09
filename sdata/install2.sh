#!/bin/bash

DOTFILES_DIR=$(pwd)

clear
echo "This is step 2 of the install process."
echo "Here we will create a backup of your .config directory and add the new dotfiles."

sleep 2

echo "" && echo -e "\e[94mChecking sudo privileges once again...\e[0m"
if ! sudo -v &>/dev/null; then
  ./sdata/finish.sh --fail
  exit 126
else
  echo -e "\e[92mSudo check!\e[0m"
fi

# Create .config backup
echo "" && echo -e "\e[94mCreating backup of ~/.config...\e[0m"
CONFIG_DIR="$HOME/.config"

if [ -d "$HOME/.config_bak" ]; then
  sudo rm -rf "$HOME/.config_bak"
fi
mkdir "$HOME/.config_bak"
sudo mv $CONFIG_DIR/* "$HOME/.config_bak/"
sleep 1 && echo -e "\e[92mDone!\e[0m"

# Copy dotfiles to ~/.config
echo "" && echo -e "\e[94mCopying dotfiles to ~/.config...\e[0m"
cp -r $DOTFILES_DIR/.config/* $CONFIG_DIR/
sleep 1 && echo -e "\e[92mDone!\e[0m"

# Copy keyd config to /etc/keyd/
echo "" && echo -e "\e[94mCopying keyd config to /etc/keyd...\e[0m"
if [ ! -d /etc/keyd/ ]; then
  sudo mkdir /etc/keyd
fi
sudo cp $DOTFILES_DIR/.etc/keyd/* /etc/keyd/
sudo systemctl restart keyd
sleep 1 && echo -e "\e[92mDone!\e[0m"
sleep 1

echo "" && echo -e "\e[94mMoving on to step 3...\e[0m"
sleep 3
cd $DOTFILES_DIR
./sdata/install3.sh
