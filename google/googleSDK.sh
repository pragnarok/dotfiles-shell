#!/bin/bash

# Sets ANSI escape codes for colors
yellow='\e[33m'
reset='\e[0m'

function googleSDK {
	export yellow=$'\033[33m'
	echo ""
	echo "Preparing to install the Google SDK"
	# Configuring the Google Public Key using GPG
	echo -ne "\tConfiguring the Google Public Key... \t\t\t\t"
	sudo rm -f /usr/share/keyrings/cloud.google.gpg
	sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
	local _ret=$?
	handle_error $_ret
	# Add the gcloud CLI
	echo -ne "	Add the gcloud CLI distribution URI as a package source... \t"
	echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list &>/dev/null
	local _ret=$?
	handle_error $_ret
	# Updating and installing the gcloud CLI
	echo -ne "	Updating and installing the gcloud CLI... \t\t\t"
	sudo apt-get update &>/dev/null && sudo apt-get install google-cloud-cli -y &>/dev/null
	local _ret=$?
	handle_error $_ret
		echo -ne "\t\tOK, your current version of the Google SDK is: "
		echo -e "${yellow} $(gcloud --version | grep SDK)${reset}  "
}

googleSDK
