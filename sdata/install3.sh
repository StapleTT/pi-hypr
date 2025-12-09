#!/bin/bash

DOTFILES_DIR=$(pwd)

clear
echo "This is step 3 of the install process."
while true; do
  read -p "This step will replace your login manager with greetd and replace your desktop environment with Sway. Are you sure you want to continue? [y/N] " input
  case "$input" in
  "y")
    echo -e "\e[94mContinuing with step 3...\e[0m"
    break
    ;;
  "n")
    echo -e "\e[94mUnderstood. Exiting step 3...\e[0m"
    exit 1
    break
    ;;
  "N")
    echo -e "\e[94mUnderstood. Exiting step 3...\e[0m"
    exit 1
    break
    ;;
  "")
    echo -e "\e[94mUnderstood. Exiting step 3...\e[0m"
    exit 1
    break
    ;;
  *)
    echo "Invalid input, please try again."
    ;;
  esac
done

sleep 2

echo "" && echo -e "\e[94mChecking sudo privileges...\e[0m"
sleep 1
if ! sudo -v &>/dev/null; then
  ./sdata/finish.sh --fail
  exit 126
else
  echo -e "\e[92mSudo check!\e[0m"
fi

# Install remaining packages
echo "" && echo -e "\e[94mInstalling remaining packages...\e[0m"
sudo pacman -S greetd hyprland rofi waybar -y
sleep 1 && echo -e "\e[92mDone!\e[0m"

# Build & install tuigreet
echo "" && echo -e "\e[94mCloning repository for tuigreet...\e[0m"
TUIGREET_DIR="$HOME/.local/src/tuigreet"
if [ ! -d "$TUIGREET_DIR" ]; then
  git clone https://github.com/apognu/tuigreet.git "$TUIGREET_DIR"
else
  git -C "$TUIGREET_DIR" pull
fi

cd $TUIGREET_DIR
echo "" && echo -e "\e[94mInstalling tuigreet...\e[0m"
cargo build --release
sudo cp target/release/tuigreet /usr/bin/
sleep 1 && echo -e "\e[92mDone!\e[0m"

# Copy greetd config to /etc/greetd
echo "" && echo -e "\e[94mCopying greetd config to /etc/greetd...\e[0m"
if [ ! -d /etc/greetd/ ]; then
  sudo mkdir /etc/greetd
fi
sudo cp $DOTFILES_DIR/.etc/greetd/* /etc/greetd/
sleep 1 && echo -e "\e[92mDone!\e[0m"

# Enable greetd
echo "" && echo -e "\e[94mEnabling greetd...\e[0m"
sudo systemctl enable greetd.service
sleep 1 && echo -e "\e[92mDone!\e[0m"

# Install networkmanager and disable iwd/dhcpcd
sudo pacman -S networkmanager

sudo systemctl disable --now iwd
sudo systemctl disable --now dhcpcd
sudo systemctl enable NetworkManager
sudo systemctl restart NetworkManager

# Finish up
cd $DOTFILES_DIR
./sdata/finish.sh --full
