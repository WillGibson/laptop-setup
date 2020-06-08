#!/bin/bash

# Three functions taken from the thoughtbot laptop script and messed
# about so we can use some components of that as we see fit here.
# See https://github.com/thoughtbot/laptop/issues/583

fancy_echo() {
    local fmt="$1"
    shift

    # shellcheck disable=SC2059
    printf "\\n$fmt\\n" "$@"
}

append_to_zshrc() {
    local text="$1" zshrc
    local skip_new_line="${2:-0}"

    if [ -w "$HOME/.zshrc.local" ]; then
        zshrc="$HOME/.zshrc.local"
    else
        zshrc="$HOME/.zshrc"
    fi

    if ! grep -Fqs "$text" "$zshrc"; then
        if [ "$skip_new_line" -eq 1 ]; then
            printf "%s\\n" "$text" >>"$zshrc"
        else
            printf "\\n%s\\n" "$text" >>"$zshrc"
        fi
    fi
}

ensure_homebrew_is_installed_and_up_to_date() {
    fancy_echo "Ensure Homebrew is installed and up to date ..."
    if ! command -v brew >/dev/null; then
        fancy_echo "Installing Homebrew ..."
        curl -fsS \
            'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby

        append_to_zshrc '# recommended by brew doctor'

        # shellcheck disable=SC2016
        append_to_zshrc 'export PATH="/usr/local/bin:$PATH"' 1

        export PATH="/usr/local/bin:$PATH"
    else
        fancy_echo "Installing Homebrew ..."
    fi

    if brew list | grep -Fq brew-cask; then
        fancy_echo "Uninstalling old Homebrew-Cask ..."
        brew uninstall --force brew-cask
    fi

    fancy_echo "Updating Homebrew and formulae ..."
    brew update
}

# Our own stuff

ensure_laptop_setup_is_up_to_date() {
    fancy_echo "Ensure laptop-setup up to date ..."
    # shellcheck disable=SC2154
    if [ ! -f "${basePath}/../.git" ]; then
        currentDirectory=$(pwd)
        cd "${basePath}/../" || exit
        git config pull.ff only
        git pull origin "$(git rev-parse --abbrev-ref HEAD)"
        cd "${currentDirectory}" || exit
    fi
}

ensure_git_name_and_email_are_set() {
    if [ -z "$GIT_USER_NAME" ]; then
        fancy_echo "Please export GIT_USER_NAME=\"<your name>\""
        exit 1
    else
        git config --global user.name "$GIT_USER_NAME"
    fi
    if [ -z "$GIT_USER_EMAIL" ]; then
        fancy_echo "Please export GIT_USER_EMAIL=\"<your email address>\""
        exit 1
    else
        git config --global user.email "$GIT_USER_EMAIL"
    fi
}

ensure_zsh_and_zsh_completions_are_installed() {
    brew reinstall zsh zsh-completions
    echo $SHELL
    if [[ "$SHELL" != "/bin/zsh" ]]; then
        chsh -s /bin/zsh
    fi
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    append_to_zshrc "export GIT_USER_NAME=\"$GIT_USER_NAME\"" 1
    append_to_zshrc "export GIT_USER_EMAIL=\"$GIT_USER_EMAIL\""
}

ensure_php_is_installed() {
    brew reinstall php@7.4
    brew link --force --overwrite php@7.4
    brew services restart php
    brew unlink php && brew link php
}