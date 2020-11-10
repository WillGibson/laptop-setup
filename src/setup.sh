#!/bin/bash

set -e

# shellcheck disable=SC2164
basePath="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# In case there's something essential in there we hand rolled
[[ -e ~/.zshrc ]] && cp ~/.zshrc "${HOME}/.zshrc.backup.$(date)"

# shellcheck disable=SC1090
source "${basePath}/components/commands/docker.sh"
source "${basePath}/components/commands/filter.sh"
source "${basePath}/components/commands/git.sh"
source "${basePath}/components/commands/homebrew.sh"
source "${basePath}/components/commands/miscellaneous.sh"
source "${basePath}/components/commands/nodejs.sh"
source "${basePath}/components/commands/php.sh"
source "${basePath}/components/commands/pull_latest.sh"
source "${basePath}/components/commands/zshrc.sh"

echo_heading "Preflight checks"
ensure_docker_not_running
ensure_git_name_and_email_are_set

pull_latest_laptop_setup_code

# Clean start for .zshrc_parts_from_laptop_setup.sh
rm -f ~/.zshrc_parts_from_laptop_setup.sh
touch ~/.zshrc_parts_from_laptop_setup.sh
append_to_zshrc_parts "#!/bin/bash" 1

run_command_but_dont_exit_on_error "ensure_homebrew_is_installed_and_up_to_date"

# always install this, we need it for the include logic
installApplicationHomebrewStyle "jq"

if include "terminal"; then
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
fi

if include "git"; then
    echo_heading "Install Git"
    ensure_git_name_and_email_env_vars_are_exported_in_zshrc
    installApplicationHomebrewStyle "git" 1
    git config --global pull.ff only
    ensure_symlink_exists "${basePath}/components/static_files/.gitignore_global" ~/.gitignore_global
    git config --global core.excludesfile ~/.gitignore_global
fi

if include "gpg"; then
    installApplicationHomebrewStyle "gpg2"
    installApplicationHomebrewStyle "pinentry-mac"
    echo_heading "Export GPG_TTY in .zshrc for signing commits"
    append_to_zshrc_parts "export GPG_TTY=$\(tty\)"
fi

if include "python"; then
    run_command_but_dont_exit_on_error "brew unlink python@3.8"
    installApplicationHomebrewStyle "python"
fi

if include "php"; then
    ensure_php_is_installed
    installApplicationHomebrewStyle "composer"
fi

if include "node"; then
    ensure_nvm_is_installed
    echo_heading "Install current long term support version of Node.js"
    echo_empty_line
    nvm install --lts
fi

if include "java"; then
    installApplicationHomebrewStyle "java11"
    installApplicationHomebrewStyle "maven"
    installApplicationHomebrewStyle "gradle"
    brew tap pivotal/tap
    installApplicationHomebrewStyle "springboot"
fi

if include "docker"; then
    installApplicationHomebrewStyle "docker"
    installApplicationHomebrewStyle "kubectl"
    installApplicationHomebrewStyle "minikube"
fi

if include "aws"; then
    rm -f /usr/local/bin/aws
    rm -f /usr/local/bin/aws_completer
    installApplicationHomebrewStyle "awscli"
    installApplicationHomebrewStyle "awsebcli"
fi

if include "serverless"; then
    installApplicationHomebrewStyle "serverless"
fi

if include "seleniumThings"; then
    installApplicationHomebrewStyle "chromedriver"
    # This does not get quarantined in the GitHub Actions pipeline so...
    pathToChromeDriver=$(which chromedriver)
    run_command_but_dont_exit_on_error "xattr -d com.apple.quarantine $pathToChromeDriver"
fi

if include "intellijIdea"; then
    installApplicationMacStyle "intellij-idea" "IntelliJ IDEA"
fi

if include "visualStudioCode"; then
    installApplicationMacStyle "visual-studio-code" "Visual Studio Code"
fi

if include "postman"; then
    installApplicationMacStyle "postman" "Postman"
fi

if include "arduino"; then
    installApplicationMacStyle "arduino" "Arduino"
fi

if include "tree"; then
    installApplicationHomebrewStyle "tree"
fi

if include "googleChrome"; then
    installApplicationMacStyle "google-chrome" "Google Chrome"
fi

if include "slack"; then
    installApplicationMacStyle "slack" "Slack"
fi

if include "microsoftTeams"; then
    installApplicationMacStyle "microsoft-teams" "Microsoft Teams" "sudo"
fi

if include "spotify"; then
    installApplicationMacStyle "spotify" "Spotify"
fi

echo_heading "Include aliases in .zshrc"
append_to_zshrc_parts "source ${basePath}/components/zshrc/aliases/miscellaneous.sh"
append_to_zshrc_parts "source ${basePath}/components/zshrc/aliases/git.sh" 1
append_to_zshrc_parts "source ${basePath}/components/zshrc/aliases/docker.sh" 1

append_to_zshrc "# Added by laptop-setup..."
append_to_zshrc "source ~/.zshrc_parts_from_laptop_setup.sh" 1

echo_heading "Run brew cleanup"
echo_empty_line
run_command_but_dont_exit_on_error "brew cleanup"

echo_heading "Run brew doctor"
echo_empty_line
run_command_but_dont_exit_on_error "brew doctor"

echo_heading "A couple of other things to note"
echo_line "\n1) To reload profile now please run...\n\nsource ~/.zshrc"
echo_line "\n2) You may still need to carry out some manual steps, these are documented at...\n\nhttps://github.com/WillGibson/laptop-setup#what-it-wont-do-for-you-yet\n"
