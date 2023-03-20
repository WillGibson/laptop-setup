#!/bin/bash

# Taken from the thoughtbot laptop script and messed about
# so we can use some components of that as we see fit here.
# See https://github.com/thoughtbot/laptop/issues/583

ensure_homebrew_is_installed_and_up_to_date() {
    echo_heading "Ensure Homebrew is installed and up to date"

    if [ "${configOnly}" == "true" ]; then
        echo_line "ConfigOnly: Skipping install of Homebrew"
    else
        if brew list --formula | grep -Fq brew-cask; then
            echo_line "\nUninstalling old Homebrew-Cask\n"
            brew uninstall --force brew-cask
        fi

        if ! command -v brew >/dev/null; then
            echo_line "\nInstalling Homebrew\n"
            /bin/bash -c \
                "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

            append_to_zshrc_parts '# recommended by brew doctor'

            # shellcheck disable=SC2016
            append_to_zshrc_parts 'export PATH="/usr/local/bin:$PATH"' 1

            export PATH="/usr/local/bin:$PATH"
        else
            echo_line "\nUpdating Homebrew and formulae\n"
            brew update
        fi
    fi

    append_to_zshrc_parts "export HOMEBREW_NO_AUTO_UPDATE=1"

    append_to_zshrc_parts "export PATH=\"/usr/local/sbin:\$PATH\""

    append_to_zshrc_parts "eval \"\$(/opt/homebrew/bin/brew shellenv)\""
}

installApplicationHomebrewStyle() {
    local applicationName="$1"
    local skipHeading="${2:-0}"
    local commandOptions="$3"

    if [ ! "$skipHeading" -eq 1 ]; then
        echo_heading "Install $applicationName"
    fi

    if [ "${configOnly}" == "true" ]; then
        echo_line "ConfigOnly: Skipping install of ${applicationName}"
        return
    fi

    echo_line "\nCheck if keg is already installed"
    # Get installedCheck without colours etc. (that's the sed bit) so we can do string comparisons...
    installedCheck="$(brew list $commandOptions $applicationName 2>&1 1>/dev/null | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" || true)"
    command="upgrade"
    if [[ "$installedCheck" == *"Error: No such keg"* ]] && \
        [[ ! "$installedCheck" == *"Found a cask named \"$applicationName\" instead"* ]]; then
        command="install"
    fi
    if [[ "$installedCheck" == *"Error: Cask '$applicationName' is not installed."* ]]; then
        command="install"
    fi
    if [[ "$installedCheck" == *"Error: $applicationName not installed"* ]]; then
        command="install"
    fi
    if [[ "$installedCheck" == *"find: $(brew --prefix)/Caskroom/$applicationName: No such file or directory"* ]]; then
        command="install"
    fi
    fullCommand="brew $command $commandOptions $applicationName"
    echo_line "\n$fullCommand"
    $fullCommand

    sudo --reset-timestamp
}
