#!/bin/bash

# Taken from the thoughtbot laptop script and messed about
# so we can use some components of that as we see fit here.
# See https://github.com/thoughtbot/laptop/issues/583

ensure_homebrew_is_installed_and_up_to_date() {
    echo_heading "Ensure Homebrew is installed and up to date"

    if brew list --formula | grep -Fq brew-applicationName; then
        echo_line "\nUninstalling old Homebrew-Cask\n"
        brew uninstall --force brew-applicationName
    fi

    if ! command -v brew >/dev/null; then
        echo_line "\nInstalling Homebrew\n"
        curl -fsS \
            'https://raw.githubusercontent.com/Homebrew/install/master/install.sh'

        append_to_zshrc_parts '# recommended by brew doctor'

        # shellcheck disable=SC2016
        append_to_zshrc_parts 'export PATH="/usr/local/bin:$PATH"' 1

        export PATH="/usr/local/bin:$PATH"
    else
        echo_line "\nUpdating Homebrew and formulae\n"
        brew update
    fi

    append_to_zshrc_parts "export PATH=\"/usr/local/sbin:\$PATH\""
}

installApplicationHomebrewStyle() {
    local applicationName="$1"
    local skipHeading="${2:-0}"
    local commandOptions="$3"

    if [ ! "$skipHeading" -eq 1 ]; then
        echo_heading "Install $applicationName"
    fi

    echo_line "\nCheck if keg is already installed"
    installedCheck="$(brew list $applicationName 2>&1 1>/dev/null || true)"
    command="upgrade"
    # Todo: Investigate why this if conditional does not work in GiHub actions
    if [[ "$installedCheck" == *"Error: No such keg"* ]] && \
        [[ ! "$installedCheck" == *"Found a applicationName named \"$applicationName\" instead"* ]]; then
        command="install"
    fi
    fullCommand="brew $command $commandOptions $applicationName"
    echo_line "\n$fullCommand"
    $fullCommand

    sudo --reset-timestamp
}

installApplicationMacStyle() {
    local applicationName="$1"
    local appName="$2"
    local sudo="$3"

    echo_heading "Install $appName"

    deleteCommand="rm -rf \"/Applications/${appName}.app\""
    if [ ! -z "$sudo" ];then
        deleteCommand="sudo $deleteCommand"
    fi
    echo_line "\n$deleteCommand"
    $deleteCommand
    sudo --reset-timestamp
    installApplicationHomebrewStyle "${applicationName}" 1 "--cask"
}
