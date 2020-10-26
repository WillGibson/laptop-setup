#!/bin/bash

# Exit on silly errors like file does not exist
set -e

# shellcheck disable=SC2164
basePath="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# In case there's something essential in there we hand rolled
cp ~/.zshrc "${HOME}/.zshrc.backup.$(date)"

# shellcheck disable=SC1090
source "${basePath}/components/commands/git.sh"
source "${basePath}/components/commands/miscellaneous.sh"
source "${basePath}/components/commands/php.sh"
source "${basePath}/components/commands/pull_latest.sh"
source "${basePath}/components/commands/zshrc.sh"

# Don't exit on errors now because homebrew will do some errors
# then find other ways to do things and succeed in the end
set +e

# Preflight checks
if docker version | grep --quiet "Server: Docker Engine"; then
    echo "Error: Please quit Docker before running the setup."
    exit 1
fi

append_to_zshrc "# The rest should have been added by laptop-setup..."

ensure_git_name_and_email_are_set

pull_latest_laptop_setup_code

ensure_homebrew_is_installed_and_up_to_date

brew reinstall iterm2

ensure_zsh_and_zsh_completions_are_installed

brew reinstall git
git config --global pull.ff only

# For signing Git commits
brew reinstall gpg2
brew reinstall pinentry-mac

# PHP
ensure_php_is_installed
brew reinstall composer

# Node.js
brew reinstall nvm
mkdir ~/.nvm
append_to_zshrc "source ${basePath}/components/zshrc/nvm_switcher.sh"

# Java
brew reinstall java11
brew reinstall maven
brew reinstall gradle
brew tap pivotal/tap
brew reinstall springboot

# Docker etc.
rm /usr/local/bin/docker
brew reinstall docker
rm -f /usr/local/bin/kubectl
brew reinstall kubectl
brew reinstall minikube

brew reinstall awscli

rm -rf /Applications/IntelliJ\ IDEA.app
brew reinstall intellij-idea

rm -rf /Applications/Postman.app
brew reinstall postman

brew reinstall tree

# Because life without music is not living
rm -rf /Applications/Spotify.app
brew reinstall spotify

append_to_zshrc "source ${basePath}/components/zshrc/aliases/miscellaneous.sh"
append_to_zshrc "source ${basePath}/components/zshrc/aliases/git.sh" 1
append_to_zshrc "source ${basePath}/components/zshrc/aliases/docker.sh" 1

append_to_zshrc "export GPG_TTY=$\(tty\)"

rm -rf ~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
update_file_line_in_situ ~/.zshrc 'plugins=(git)' 'plugins=(docker git zsh-autosuggestions)'

ensure_zshrc_correction_is_used

ensure_zshrc_completion_waiting_dots_are_used

ensure_correct_ohmyzsh_theme_is_used "${basePath}/components/ohmyzsh/willgibson.zsh-theme" "willgibson"

fancy_echo "To reload profile now please run...\nsource ~/.zshrc"

fancy_echo "You may still need to carry out some manual steps, these are documented at...\nhttps://github.com/WillGibson/laptop-setup#what-it-wont-do-for-you-yet\n"
