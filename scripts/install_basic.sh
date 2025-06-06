#!/bin/bash
function installBasicPrograms() {
    clear
    echo ""
    echo "Installing the basic prerequisites individually:"

    local packages=(
        apt-transport-https
        ca-certificates
        software-properties-common
        lsb-release
        fzf
        golang-go
        gcc
        gnupg
        curl
        tilix
        sudo
    )

    for pkg in "${packages[@]}"; do
        printf "\t%-40s" "Installing ${pkg}..."
        sudo apt-get install -y "$pkg" &>/dev/null
        if [ $? -eq 0 ]; then
            echo -e "done. ✅"
        else
            echo -e "failed. ⚠️"
        fi
    done
}
