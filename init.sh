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

handle_error() {
	local error_code="$1"
	if [ "$error_code" -ne 0 ]; then
		echo -e "failed. ⚠️"
		# echo "Failure, please check your system. Error code: $error_code"
		# errno "$error_code"
		# exit 1
		echo -e "\t\t${red}Failure, please check your system. Error: ($error_code); \n${black_back}$(cat $temp_file) ${reset}" >&2
		rm "$temp_file"
		exit "$error_code"
	else
		echo -e "done. ✅"
	fi
	sleep 1
}

function updateSystem() {
	# below command will Update package lists
	echo "Upgrading your system first 🥱"
	echo -ne "\tRunning apt-get update... \t\t\t\t\t"
	sudo apt update >/dev/null 2>"$temp_file"
	local _ret=$?
	handle_error $_ret

	# below command will Upgrade the packages that can be upgraded
	echo -ne "\tRunning apt-get upgrade... \t\t\t\t\t"
	sudo apt upgrade -y >/dev/null 2>"$temp_file"
	local _ret=$?
	handle_error $_ret

	# below command will Remove unnecessary packages and dependencies for good memory management
	echo -ne "\tRunning Remove unnecessary packages apt-get autoremove... \t"
	sudo apt autoremove -y >/dev/null 2>"$temp_file"
	local _ret=$?
	handle_error $_ret

	# below command will Clean package cache
	echo -ne "\tRunning Clean package cache apt-get clean... \t\t\t"
	sudo apt clean -y >/dev/null 2>"$temp_file"
	local _ret=$?
	handle_error $_ret

	# below command will Display system update status on terminal to know if the update and upgrade is successfull
	echo "System updates and upgrades completed successfully. 🍕"
	sleep 1
}

function updategit() {
	function gitconfig() {
		while :; do
			echo -n "      Enter your name: "
			IFS= read -r GIT_NAME
			if [ -z "$GIT_NAME" ]; then
				echo "          Please, the name cannot be null!!! Try again. ☹️"
			else
				break
			fi
			# break
		done

		while :; do
			echo -n "      Enter your email: "
			IFS= read -r GIT_EMAIL
			if [ -z "$GIT_EMAIL" ]; then
				echo "          Please, the email cannot be null!!! Try again. ☹️"
			else
				break
			fi
			# break
		done

		git config --global user.name "$GIT_NAME" && git config --global user.email "$GIT_EMAIL"
		local _ret=$?
		if [ $_ret -ne 0 ]; then
			echo "⚠️"
			echo "Failure, please check your system. Error code: $_ret"
			errno $_ret
			exit 1
		else
			echo " "
			echo -n "      Your current configurations of gitconfig are:"
			cat ~/.gitconfig
		fi

	}
	echo ""
	echo "Install or update Git in your system"
	echo -ne "\tConfiguring the GIT repository... \t\t\t\t"
	sudo add-apt-repository ppa:git-core/ppa -y >/dev/null 2>"$temp_file"
	local _ret=$?
	handle_error $_ret

	echo -ne "\tInstall package git... \t\t\t\t\t\t"
	sudo apt-get update &>/dev/null && sudo apt-get -y install git >/dev/null 2>"$temp_file"
	local _ret=$?
	handle_error $_ret
	echo ""
	echo -e "\t\tOK, your current version of GIT is: ${black_back}$(git -v | awk '{print $3}')${reset}"
	echo ""
	echo -e "\tChecking gitconfig settings...."

	if [ -f ~/.gitconfig ]; then
		echo ""
		echo -e "\t${yellow} Your Git configuration file already exists and is in the format below:${reset}"
		echo ""
		echo -e "${black_back}\t$(cat ~/.gitconfig)${reset}"
		echo ""
		echo -ne "\t${yellow} Is the information correct or do you want to reconfigure it? (y/n)?${reset}  "
		IFS= read -r ANSWER
		if [[ "$ANSWER" =~ ^[Yy](es)?$ ]]; then
			echo -e "\t\tRecreating the file..."
			echo ""
			# Calls the function responsible for configuring gitconfig
			gitconfig
		else
			echo ""
			echo -ne "\tYour gitconfig will not change...."
			echo -e "\t\t\t\tdone. ✅"
		echo "Git updates and configurations completed successfully."
		fi
	else
		# Calls the function responsible for configuring gitconfig
		gitconfig
		echo "Git updates and configurations completed successfully."
	fi
}

function installBasicPrograms() {
	echo ""
	echo -ne "Installing the basic prerequisites... \t\t\t\t\t"
	sudo apt install -y \
		apt-transport-https \
		ca-certificates \
		software-properties-common \
		lsb-release \
		fzf \
		golang-go \
		gcc \
		gnupg \
		curl \
		tilix \
		sudo -y &>/dev/null
	# zsh     \
	# flameshot \
	# podman \
	local _ret=$?
	handle_error $_ret
}

function installZSH() {
	sudo echo ""
	echo "Install ZSH and preparing your terminal ==> $USER"
	echo -ne "\tInstalling ZSH... \t\t\t\t\t\t"
	## Install ZSH
	sudo apt install zsh -y &>/dev/null
	local _ret=$?
	handle_error $_ret
	## Install OhMyZSH
	echo -ne "\tInstalling OhMyZSH... \t\t\t\t\t"
	if [ -d "$HOME/.oh-my-zsh" ]; then
		echo -e "\tdone. ✅ ${green_back} OhMYZSH is already configured on $HOME/.oh-my-zsh!!!!${reset}"
	else
		echo -ne "\tInstalling OhMyZSH... \t\t\t\t\t\t"
		echo ""
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
		local _ret=$?
		handle_error $_ret
	fi
	## Install PowerLevel10k
	echo -ne "\tConfiguring PowerLevel10k... \t\t\t\t"
	if [ -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
		echo -e "\tdone. ✅ ${green_back} PowerLevel10k is already configured on $HOME/.oh-my-zsh/custom/themes/powerlevel10k!!!!${reset}"
	else
		echo ""
		echo -ne "\tConfiguring PowerLevel10k... \t\t\t\t"
		echo ""
		sudo chsh -s /bin/zsh "$USER"
		git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/themes/powerlevel10k &>/dev/null
		cp terminal/.p10k.zsh ~/.p10k.zsh
		mkdir ~/.local/share/fonts
		cp terminal/MesloLGS_NF_Regular.ttf ~/.local/share/fonts/MesloLGS_NF_Regular.ttf
		fc-cache -f
		## Install zsh-autosuggestions and zsh-syntax-highlighting
		echo -ne "\tConfiguring zsh-autosuggestions plugin... \t\t"
		sudo chsh -s /bin/zsh "$USER"
		git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions &>/dev/null
		echo -e "\tdone. ✅"
		echo -ne "\tConfiguring zsh-autosuggestions plugin... \t\t"
		sudo chsh -s /bin/zsh "$USER"
		git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting &>/dev/null
		echo -e "\tdone. ✅"		
	fi
}

function installClouds() {
	pwd
	# shellcheck source=/dev/null
	. "$(pwd)"/google/googleSDK.sh
}

main() {
	updateSystem
	updategit
	installBasicPrograms
	installZSH
	installClouds
}

main
