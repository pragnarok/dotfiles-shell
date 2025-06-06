#!/bin/bash
function installVim() {
    clear
    echo -ne "Installing Vim and setting as default editor...\t\t\t"
    sudo apt install -y vim &>/dev/null
    handle_error $?

    sudo update-alternatives --set editor /usr/bin/vim.basic &>/dev/null

    if ! grep -q "export EDITOR=vim" ~/.bashrc && ! grep -q "export EDITOR=vim" ~/.zshrc; then
        echo "export EDITOR=vim" >> ~/.bashrc
        echo "export EDITOR=vim" >> ~/.zshrc
    fi

    git config --global core.editor "vim"
    echo -e "done. ✅"
}
