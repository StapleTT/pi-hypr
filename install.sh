#!/bin/bash

# cd to actual installer directory
cd "$(dirname "$(realpath "$0")")" || exit 1

clear

echo -e "\e[94m[$0]\e[0m: Hi there! Before we start, you should know exactly what you're running. This script will:"
echo ' - Install Hyprland & tuigreet'
echo ' - Replace your existing terminal and shell with Foot & Fish'
echo ' - Install & configure Neovim'
echo ' - Rebind Caps Lock to Escape'

echo ""

echo "Now that you know what this script does, what would you like to do?"
echo "NOTE: This is intended to be run on arch-based distros with the aarch64 architecture. Running this script on other systems may present issues."
echo ' [1] Install dotfiles'
echo ' [2] Exit'

while true; do
  read -p "Enter an option: " input
  case "$input" in
  1)
    echo -e "\e[94mContinuing with ./sdata/install1.sh...\e[0m"
    sleep 3
    ./sdata/install1.sh
    break
    ;;
  2)
    echo -e "\e[94mExiting script..."
    exit 1
    break
    ;;
  *)
    echo "Invalid input, please try again."
    ;;
  esac
done
