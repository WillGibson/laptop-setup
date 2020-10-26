#!/bin/bash

set -e

# shellcheck disable=SC2164
basePath="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# In case there's something essential in there we hand rolled
cp ~/.zshrc "${HOME}/.zshrc.backup.$(date)"

# shellcheck disable=SC1090
source "${basePath}/components/commands/docker.sh"
source "${basePath}/components/commands/git.sh"
source "${basePath}/components/commands/miscellaneous.sh"
source "${basePath}/components/commands/nodejs.sh"
source "${basePath}/components/commands/php.sh"
source "${basePath}/components/commands/pull_latest.sh"
source "${basePath}/components/commands/zshrc.sh"

# Preflight checks
ensure_docker_not_running
ensure_git_name_and_email_are_set

append_to_zshrc "# The rest should have been added by laptop-setup..."

pull_latest_laptop_setup_code

set +e && ensure_homebrew_is_installed_and_up_to_date && set -e

# Terminal
brew reinstall iterm2
ensure_zsh_is_installed
brew reinstall zsh zsh-completions
ensure_ohmyzsh_is_installed
ensure_zsh_autosuggestions_are_installed
ensure_zsh_correction_is_used
ensure_zsh_completion_waiting_dots_are_used
ensure_correct_ohmyzsh_theme_is_used "${basePath}/components/ohmyzsh/willgibson.zsh-theme" "willgibson"
update_file_line_in_situ ~/.zshrc 'plugins=(git)' 'plugins=(docker git zsh-autosuggestions)'

# Git
ensure_git_name_and_email_env_vars_are_exported_in_zshrc
brew reinstall git
git config --global pull.ff only

# For signing Git commits
brew reinstall gpg2
brew reinstall pinentry-mac

# PHP
ensure_php_is_installed
brew reinstall composer

# NVM & Node.js
ensure_nvm_is_installed
nvm install --lts

# Java etc.
brew reinstall java11
brew reinstall maven
brew reinstall gradle
brew tap pivotal/tap
brew reinstall springboot

# Docker etc.
rm -f /usr/local/bin/docker
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

fancy_echo "To reload profile now please run...\nsource ~/.zshrc"

fancy_echo "You may still need to carry out some manual steps, these are documented at...\nhttps://github.com/WillGibson/laptop-setup#what-it-wont-do-for-you-yet\n"
