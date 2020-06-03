#!/bin/bash

basePath=${BASH_SOURCE%/*}

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

ensure_php_is_installed

# append_to_zshrc 'source $ZSH/oh-my-zsh.sh'

append_to_zshrc "source ${basePath}/components/zshrc/aliases/miscellaneous.sh"
append_to_zshrc "source ${basePath}/components/zshrc/aliases/git.sh" 1
append_to_zshrc "source ${basePath}/components/zshrc/aliases/docker.sh" 1

append_to_zshrc "commitconfig"

# Todo: .zshrc plugins - docker, git, zsh-autosuggestions
# Todo: .zshrc ENABLE_CORRECTION="true"
# Todo: .zshrc COMPLETION_WAITING_DOTS="true"

# Todo: willgibson.zsh-theme

# Todo: Install Spotify??

# Todo: DisplayLink??

# Todo: Docker

# Todo: Intellij

# Todo: Postman

fancy_echo "To reload profile now please run...\n\nsource ~/.zshrc\n"
