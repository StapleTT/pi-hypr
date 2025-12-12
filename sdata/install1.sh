#!/bin/bash

DOTFILES_DIR=$(pwd)

clear
echo "Welcome to step 1 of the install script."
echo "Please note that this script will require sudo privileges to work properly."
sleep 2

echo "" && echo -e "\e[94mChecking sudo privileges...\e[0m"
sleep 1
if ! sudo -v &>/dev/null; then
  ./sdata/finish.sh --fail
  exit 126
else
  echo -e "\e[92mSudo check!\e[0m"
fi

# Update system
echo "" && echo -e "\e[94mPerforming system update...\e[0m"
sudo pacman -Syu
sleep 1 && echo -e "\e[92mDone!\e[0m"

echo "" && echo -e "\e[94mInstalling packages...\e[0m"
# Install packages
sudo pacman -S neovim gcc grimshot fastfetch foot keyd fish curl git -y

# Install Rust via rustup if not already installed
echo "" && echo -e "\e[94mInstalling Rust...\e[0m"
if ! command -v rustup >/dev/null 2>&1; then
  curl https://sh.rustup.rs -sSf | sh -s -- -y
  source $HOME/.cargo/env
fi
sleep 1 && echo -e "\e[92mDone!\e[0m"

# Install Starship
echo "" && echo -e "\e[94mInstalling Starship...\e[0m"
if ! command -v starship >/dev/null 2>&1; then
  curl -sS https://starship.rs/install.sh | sh -s -- -y
fi
sleep 1 && echo -e "\e[92mDone!\e[0m"

# Install eza via cargo
echo "" && echo -e "\e[94mInstalling eza...\e[0m"
if ! command -v eza >/dev/null 2>&1; then
  cargo install eza
fi
sleep 1 && echo -e "\e[92mDone!\e[0m"

# Install CascadiaCode Nerd Font
echo "" && echo -e "\e[94mInstalling CascadiaCode Nerd Font...\e[0m"
FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"

cd "$FONT_DIR"
if [ ! -d "$FONT_DIR/CascadiaCodeNF" ]; then
  wget -q https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CascadiaCode.zip -O CascadiaCode.zip
  unzip CascadiaCode.zip -d CascadiaCodeNF
  rm CascadiaCode.zip
fi

fc-cache -fv >/dev/null
sleep 1 && echo -e "\e[92mDone!\e[0m"
sleep 1

# Move on to step 2 (copy .config and other files)
cd $DOTFILES_DIR
echo "" && echo -e "\e[94mMoving on to step 2...\e[0m" && sleep 3
./sdata/install2.sh
