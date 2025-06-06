#!/bin/bash
function updateSystem() {
    clear
    echo "Upgrading your system first 🥱"
    printf "\t%-50s" "Running apt-get update..."
    sudo apt update >/dev/null 2>/tmp/temp_file
    handle_error $?

    printf "\t%-50s" "Running apt-get upgrade..."
    sudo apt upgrade -y >/dev/null 2>/tmp/temp_file
    handle_error $?

    printf "\t%-50s" "Removing unnecessary packages (autoremove)..."
    sudo apt autoremove -y >/dev/null 2>/tmp/temp_file
    handle_error $?

    printf "\t%-50s" "Cleaning package cache (clean)..."
    sudo apt clean -y >/dev/null 2>/tmp/temp_file
    handle_error $?

    echo "System updates and upgrades completed successfully. 🍕"
    sleep 1
}
