#!/bin/bash

# shellcheck disable=SC2164
basePath="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

cp ~/.zshrc "${HOME}/.zshrc.backup.$(date)"

# shellcheck disable=SC1090
source "${basePath}/components/install_commands.sh"

append_to_zshrc "# The rest should have been added by laptop-setup..."

ensure_git_name_and_email_are_set

ensure_laptop_setup_is_up_to_date

ensure_homebrew_is_installed_and_up_to_date

brew cask reinstall iterm2

ensure_zsh_and_zsh_completions_are_installed

brew reinstall nvm

brew reinstall git

brew reinstall awscli

ensure_php_is_installed

append_to_zshrc "source ${basePath}/components/zshrc/aliases/miscellaneous.sh"
append_to_zshrc "source ${basePath}/components/zshrc/aliases/git.sh" 1
append_to_zshrc "source ${basePath}/components/zshrc/aliases/docker.sh" 1

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
update_file_line_in_situ ~/.zshrc 'plugins=(git)' 'plugins=(docker git zsh-autosuggestions)'

ensure_zshrc_correction_is_used

ensure_zshrc_completion_waiting_dots_are_used

ensure_correct_ohmyzsh_theme_is_used "${basePath}/components/ohmyzsh/willgibson.zsh-theme" "willgibson"

# Todo: Install Spotify??

# Todo: DisplayLink??

# Todo: Docker

# Todo: Intellij

# Todo: Postman

fancy_echo "To reload profile now please run...\n\nsource ~/.zshrc\n"
