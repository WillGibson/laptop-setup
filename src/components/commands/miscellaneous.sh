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

ensure_homebrew_is_installed_and_up_to_date() {
    fancy_echo "Ensure Homebrew is installed and up to date ..."
    if ! command -v brew >/dev/null; then
        fancy_echo "Installing Homebrew ..."
        curl -fsS \
            'https://raw.githubusercontent.com/Homebrew/install/master/install.sh'

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

update_file_line_in_situ() {
    filePath="$1"
    defaultLine="$2"
    desiredLine="$3"

    if grep -Fqsx "${defaultLine}" "${filePath}" && ! grep -Fqsx "${desiredLine}" "${filePath}"; then
        find "${filePath}" -type f -exec \
            sed -i '' -e "s/${defaultLine}/${desiredLine}/g" {} \;
    fi
}

ensure_symlink_exists() {

    realPath="$1"
    linkPath="$2"

    rm -f "${linkPath}"
    ln -s ${realPath} ${linkPath}

    echo "Created symlink $realPath -> $linkPath"
}
