#!/bin/bash

set -e

while getopts "c" opt; do
    case $opt in
        c) configOnly="true"
    ;;
        \?) echo "Invalid option -$OPTARG" >&2
        exit 1
    ;;
    esac
done

# shellcheck disable=SC2164
basePath="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# In case there's something essential in there we hand rolled
[[ -e ~/.zshrc ]] && cp ~/.zshrc "${HOME}/.zshrc.backup.$(date)"

# shellcheck disable=SC1090
source "${basePath}/components/commands/additionalCommands.sh"
source "${basePath}/components/commands/curl.sh"
source "${basePath}/components/commands/docker.sh"
source "${basePath}/components/commands/filter.sh"
source "${basePath}/components/commands/git.sh"
source "${basePath}/components/commands/homebrew.sh"
source "${basePath}/components/commands/identity.sh"
source "${basePath}/components/commands/jenv.sh"
source "${basePath}/components/commands/miscellaneous.sh"
source "${basePath}/components/commands/nodejs.sh"
source "${basePath}/components/commands/php.sh"
source "${basePath}/components/commands/pull_latest.sh"
source "${basePath}/components/commands/rvm.sh"
source "${basePath}/components/commands/ssh.sh"
source "${basePath}/components/commands/zshrc.sh"

echo_heading "Preflight checks"
ensure_docker_not_running
ensure_identity_related_environment_variables_are_set
ensure_git_name_and_email_are_set_for_this_run
ensure_ssh_rsa_works
pull_latest_laptop_setup_code

# Clean start for .zshrc_parts_from_laptop_setup.sh
rm -f ~/.zshrc_parts_from_laptop_setup.sh
touch ~/.zshrc_parts_from_laptop_setup.sh
append_to_zshrc_parts "#!/bin/bash" 1

ensure_identity_related_environment_variables_are_set_in_zshrc

export HOMEBREW_NO_AUTO_UPDATE=1

run_command_but_dont_exit_on_error "ensure_homebrew_is_installed_and_up_to_date"

# Always install this, we need it for the include logic...
installApplicationHomebrewStyle "jq"

# Other things we are going to want all the time...
installApplicationHomebrewStyle "coreutils"
ensure_curl_is_installed
installApplicationHomebrewStyle "watch"

additionalCommands "pre"

if include "terminal"; then
    echo_heading "Install iTerm2, ohmyzsh etc."
    installApplicationHomebrewStyle "iterm2" 1
    ensure_zsh_is_installed
    ensure_ohmyzsh_is_installed
    installApplicationHomebrewStyle "zsh-completions" 1
    ensure_zsh_autosuggestions_are_installed
    ensure_zsh_completion_waiting_dots_are_used
    ensure_correct_ohmyzsh_theme_is_used "${basePath}/components/ohmyzsh/willgibson.zsh-theme" "willgibson"
    update_file_line_in_situ ~/.zshrc 'plugins=(git)' 'plugins=(docker git kubectl zsh-autosuggestions)'
    append_to_zshrc_parts "ZSH_AUTOSUGGEST_MANUAL_REBIND=false" # This might need to go before it loads ohmyzsh
fi

if include "git"; then
    ensure_git_is_installed
fi

if include "gpg"; then
    installApplicationHomebrewStyle "gpg2"
    installApplicationHomebrewStyle "pinentry-mac"
    append_to_zshrc_parts "export GPG_TTY=$\(tty\)"
fi

if include "python"; then
    installApplicationHomebrewStyle "pyenv"
    if [ ! "${configOnly}" == "true" ]; then
        pyenv install --skip-existing 3
    fi
    source "${basePath}/components/scripts/python/pyenv_init.sh"
    append_to_zshrc_parts "source ${basePath}/components/scripts/python/pyenv_init.sh"
fi

if include "php"; then
    ensure_php_is_installed
    installApplicationHomebrewStyle "composer"
fi

if include "node"; then
    ensure_nvm_is_installed
    if [ ! "${configOnly}" == "true" ]; then
        echo_heading "Install current long term support version of Node.js"
        echo_empty_line
        nvm install --lts
    fi
fi

if include "java"; then
    ensure_jenv_is_installed
    installApplicationHomebrewStyle "java11"
    installApplicationHomebrewStyle "openjdk@17"
    installApplicationHomebrewStyle "maven"
    installApplicationHomebrewStyle "gradle"
    brew tap spring-io/tap
    installApplicationHomebrewStyle "spring-boot"
fi

if include "docker"; then
    ensure_docker_is_installed
fi

if include "kubernetes"; then
    installApplicationHomebrewStyle "krew"
    append_to_zshrc_parts 'export PATH=${PATH}:${HOME}/.krew/bin'
    installApplicationHomebrewStyle "kubectl"
    append_to_zshrc_parts "export KUBECONFIG=$HOME/.kube/config"
    append_to_zshrc_parts "${basePath}/components/scripts/kubernetes/using_namespace.sh"
    installApplicationHomebrewStyle "minikube"
fi

if include "rubyThings"; then
    ensure_rvm_is_installed
fi

if include "aws"; then
    rm -f /usr/local/bin/aws
    rm -f /usr/local/bin/aws_completer
    installApplicationHomebrewStyle "awscli"
    brew unlink awscli && brew link awscli
    installApplicationHomebrewStyle "awsebcli"
    installApplicationHomebrewStyle "copilot"
fi

if include "serverless"; then
    installApplicationHomebrewStyle "serverless"
fi

if include "terraform"; then
    installApplicationHomebrewStyle "tfenv"
    tfenv install latest
    installApplicationHomebrewStyle "tflint"
fi

if include "checkov"; then
    installApplicationHomebrewStyle "checkov"
fi

if include "seleniumThings"; then
    installApplicationHomebrewStyle "chromedriver"
    # This does not get quarantined in the GitHub Actions pipeline so...
    pathToChromeDriver=$(which chromedriver)
    run_command_but_dont_exit_on_error "xattr -d com.apple.quarantine $pathToChromeDriver"
fi

if include "intellijIdea"; then
    installApplicationHomebrewStyle "intellij-idea" 0 "--cask"
    append_to_zshrc_parts 'export PATH=${PATH}:/Applications/IntelliJ\ IDEA.app/Contents/MacOS'
fi

if include "visualStudioCode"; then
    installApplicationHomebrewStyle "visual-studio-code" 0 "--cask"
fi

if include "postman"; then
    installApplicationHomebrewStyle "postman" 0 "--cask"
fi

if include "arduino"; then
    installApplicationHomebrewStyle "arduino" 0 "--cask"
fi

if include "tree"; then
    installApplicationHomebrewStyle "tree"
fi

if include "rectangle"; then
    installApplicationHomebrewStyle "rectangle"
fi

if include "braveBrowser"; then
    installApplicationHomebrewStyle "brave-browser" 0 "--cask"
fi

if include "googleChrome"; then
    installApplicationHomebrewStyle "google-chrome"
fi

if include "slack"; then
    installApplicationHomebrewStyle "slack"
fi

if include "microsoftTeams"; then
    installApplicationHomebrewStyle "microsoft-teams" 0 "--cask"
fi

if include "spotify"; then
    run_command_but_dont_exit_on_error 'installApplicationHomebrewStyle "spotify" 0 "--cask"'
fi

echo_heading "Include aliases in .zshrc"
append_to_zshrc_parts "source ${basePath}/components/zshrc/aliases/miscellaneous.sh"
append_to_zshrc_parts "source ${basePath}/components/zshrc/aliases/git.sh" 1
append_to_zshrc_parts "source ${basePath}/components/zshrc/aliases/docker.sh" 1

append_to_zshrc_parts "${basePath}/components/scripts/ssh/ssh_add.sh"

append_to_zshrc "# Added by laptop-setup..."
append_to_zshrc "source ~/.zshrc_parts_from_laptop_setup.sh" 1

additionalCommands "post"

echo_heading "Run brew cleanup"
echo_empty_line
run_command_but_dont_exit_on_error "brew cleanup"

echo_heading "Run brew doctor"
echo_empty_line
run_command_but_dont_exit_on_error "brew doctor"

echo_heading "Check contents of ~/.zshrc_parts_from_laptop_setup.sh"
echo_empty_line
cat ~/.zshrc_parts_from_laptop_setup.sh

echo_heading "A couple of other things to note"
echo_line "\n1) To reload profile now please run...\n\nsource ~/.zshrc"
echo_line "\n2) You may still need to carry out some manual steps, these are documented at...\n\nhttps://github.com/WillGibson/laptop-setup#what-it-wont-do-for-you-yet\n"
