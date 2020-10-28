#!/bin/bash

set -e

# shellcheck disable=SC2164
basePath="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# In case there's something essential in there we hand rolled
[[ -e ~/.zshrc ]] && cp ~/.zshrc "${HOME}/.zshrc.backup.$(date)"

# shellcheck disable=SC1090
source "${basePath}/components/commands/docker.sh"
source "${basePath}/components/commands/git.sh"
source "${basePath}/components/commands/homebrew.sh"
source "${basePath}/components/commands/miscellaneous.sh"
source "${basePath}/components/commands/nodejs.sh"
source "${basePath}/components/commands/php.sh"
source "${basePath}/components/commands/pull_latest.sh"
source "${basePath}/components/commands/zshrc.sh"

# Clean start for .zshrc_parts_from_laptop_setup.sh
rm -f ~/.zshrc_parts_from_laptop_setup.sh
touch ~/.zshrc_parts_from_laptop_setup.sh
append_to_zshrc_parts "#!/bin/bash" 1

echo_heading "Preflight checks"
ensure_docker_not_running
ensure_git_name_and_email_are_set

#pull_latest_laptop_setup_code

set +e && ensure_homebrew_is_installed_and_up_to_date && set -e

# Terminal
echo_heading "Install iTerm2, ohmyzsh etc."
installApplicationHomebrewStyle "iterm2" 1
ensure_zsh_is_installed
ensure_ohmyzsh_is_installed
installApplicationHomebrewStyle "zsh-completions" 1
ensure_zsh_autosuggestions_are_installed
ensure_zsh_correction_is_used
ensure_zsh_completion_waiting_dots_are_used
ensure_correct_ohmyzsh_theme_is_used "${basePath}/components/ohmyzsh/willgibson.zsh-theme" "willgibson"
update_file_line_in_situ ~/.zshrc 'plugins=(git)' 'plugins=(docker git zsh-autosuggestions)'

# Git
echo_heading "Install Git"
ensure_git_name_and_email_env_vars_are_exported_in_zshrc
#installApplicationHomebrewStyle "git" 1
#git config --global pull.ff only
#ensure_symlink_exists "${basePath}/components/static_files/.gitignore_global" ~/.gitignore_global
#git config --global core.excludesfile ~/.gitignore_global
#
## GPG for signing Git commits
#installApplicationHomebrewStyle "gpg2"
#installApplicationHomebrewStyle p"inentry-mac"
#
## Python3
#brew unlink python@3.8
#installApplicationHomebrewStyle "python"
#
## PHP
#ensure_php_is_installed
#installApplicationHomebrewStyle "composer"

# NVM & Node.js
ensure_nvm_is_installed
#echo_heading "Install current long term support version of Node.js"
#echo_empty_line
#nvm install --lts
#
## Java etc.
#installApplicationHomebrewStyle "java11"
#installApplicationHomebrewStyle "maven"
#installApplicationHomebrewStyle "gradle"
#brew tap pivotal/tap
#installApplicationHomebrewStyle "springboot"
#
## Docker etc.
#rm -f /usr/local/bin/docker
#rm -rf /usr/local/Cellar/docker/
#installApplicationHomebrewStyle "docker"
#rm -f /usr/local/bin/kubectl
#installApplicationHomebrewStyle "kubectl"
#installApplicationHomebrewStyle "minikube"
#
## AWS
#rm -f /usr/local/bin/aws
#rm -f /usr/local/bin/aws_completer
#installApplicationHomebrewStyle "awscli"
#
#installApplicationMacStyle "intellij-idea" "IntelliJ IDEA"
#
#installApplicationMacStyle "visual-studio-code" "Visual Studio Code"
#
#installApplicationMacStyle "postman" "Postman"
#
#installApplicationHomebrewStyle "tree"
#
#installApplicationMacStyle "google-chrome" "Google Chrome"
#
#installApplicationMacStyle "slack" "Slack"
#
#installApplicationMacStyle "microsoft-teams" "Microsoft Teams" "sudo"
#
#installApplicationMacStyle "spotify" "Spotify"

echo_heading "Include aliases in .zshrc"
append_to_zshrc_parts "source ${basePath}/components/zshrc/aliases/miscellaneous.sh"
append_to_zshrc_parts "source ${basePath}/components/zshrc/aliases/git.sh" 1
append_to_zshrc_parts "source ${basePath}/components/zshrc/aliases/docker.sh" 1

echo_heading "Export GPG_TTY in .zshrc for signing commits"
append_to_zshrc_parts "export GPG_TTY=$\(tty\)"

append_to_zshrc "# Added by laptop-setup..."
append_to_zshrc "source ~/.zshrc_parts_from_laptop_setup.sh" 1

#echo_heading "Run brew cleanup"
#echo_empty_line
#set +e && brew cleanup && set -e
#
#echo_heading "Run brew doctor"
#echo_empty_line
#set +e && brew doctor && set -e

echo_heading "A couple of other things to note"
echo_line "\n1) To reload profile now please run...\n\nsource ~/.zshrc"
echo_line "\n2) You may still need to carry out some manual steps, these are documented at...\n\nhttps://github.com/WillGibson/laptop-setup#what-it-wont-do-for-you-yet\n"
