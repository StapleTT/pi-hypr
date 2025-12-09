#!/bin/bash

case $1 in
  "--partial")
    echo "" && echo -e "\e[92mInstall complete. Please log out and log back in for changes to take effect."
    exit 1
    ;;
  "--full")
    echo "" && echo -e "\e[92mInstall complete. A full reboot is required for changes to take effect.\e[0m"
    while true ; do
      read -p "Reboot now? [Y/n]: " input
      case "$input" in
        y)
          sudo reboot now
          break
          ;;
        Y)
          sudo reboot now
          break
          ;;
        "")
          sudo reboot now
          break
          ;;
        n)
          exit 1
          break
          ;;
        *)
          echo "Invalid input, please try again."
          ;;
      esac
    done
    ;;
  "--fail")
    echo "" && echo -e "\e[91mSudo check failed. Do you have the right permissions?\e[0m"
    echo "Script exited with code 126."
    ;;
esac
