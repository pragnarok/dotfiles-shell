#!/bin/bash

sudo clear

# Sets ANSI escape codes for colors
red='\e[0;31m'
green='\e[0;32m'
yellow='\e[33m'
green_back='\e[1;42m'
black_back='\e[1;40m'
reset='\e[0m'
temp_file=/tmp/temp_file
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

handle_error() {
	local error_code="$1"
	if [ "$error_code" -ne 0 ]; then
		echo -e "failed. ⚠️"
		echo -e "\t\t${red}Failure, please check your system. Error: ($error_code); \n${black_back}$(cat $temp_file) ${reset}" >&2
		rm "$temp_file"
		exit "$error_code"
	else
		echo -e "done. ✅"
	fi
	sleep 1
}

# Source modular functions
source "$SCRIPT_DIR/scripts/update_system.sh"
source "$SCRIPT_DIR/scripts/update_git.sh"
source "$SCRIPT_DIR/scripts/install_basic.sh"
source "$SCRIPT_DIR/scripts/install_vim.sh"
source "$SCRIPT_DIR/scripts/install_zsh.sh"
source "$SCRIPT_DIR/scripts/install_devops.sh"
source "$SCRIPT_DIR/scripts/install_clouds.sh"

main() {
	updateSystem
	updategit
	installBasicPrograms
	installVim
	installZSH
	installDevOpsTools
	installClouds
}

main

