#!/bin/bash
function updategit() {
    clear
    function gitconfig() {
        while :; do
            echo -n "      Enter your name: "
            IFS= read -r GIT_NAME
            [ -n "$GIT_NAME" ] && break || echo "          Please, the name cannot be null!!! Try again. ☹️"
        done

        while :; do
            echo -n "      Enter your email: "
            IFS= read -r GIT_EMAIL
            [ -n "$GIT_EMAIL" ] && break || echo "          Please, the email cannot be null!!! Try again. ☹️"
        done

        git config --global user.name "$GIT_NAME" && git config --global user.email "$GIT_EMAIL"
        local _ret=$?
        if [ $_ret -ne 0 ]; then
            echo "⚠️"
            echo "Failure, please check your system. Error code: $_ret"
            exit 1
        else
            echo " "
            echo -n "      Your current configurations of gitconfig are:"
            cat ~/.gitconfig
        fi
    }

    echo ""
    echo "Install or update Git in your system"
    printf "\t%-50s" "Configuring the GIT repository..."
    sudo add-apt-repository ppa:git-core/ppa -y >/dev/null 2>/tmp/temp_file
    handle_error $?

    printf "\t%-50s" "Install package git..."
    sudo apt-get update &>/dev/null && sudo apt-get -y install git >/dev/null 2>/tmp/temp_file
    handle_error $?

    echo ""
    echo -e "\t\tOK, your current version of GIT is: $(git --version | awk '{print $3}')"
    echo ""
    echo -e "\tChecking gitconfig settings...."

    if [ -f ~/.gitconfig ]; then
        echo ""
        echo -e "\t Your Git configuration file already exists:"
        echo ""
        echo -e "\t$(cat ~/.gitconfig)"
        echo ""
        echo -ne "\t Is the information correct or do you want to reconfigure it? (y/n)?  "
        IFS= read -r ANSWER
        if [[ "$ANSWER" =~ ^[Yy](es)?$ ]]; then
            echo -e "\t\tRecreating the file..."
            echo ""
            gitconfig
        else
            echo ""
            echo -ne "\tYour gitconfig will not change...."
            echo -e "\t\t\t\tdone. ✅"
            echo "Git updates and configurations completed successfully."
        fi
    else
        gitconfig
        echo "Git updates and configurations completed successfully."
    fi
}
