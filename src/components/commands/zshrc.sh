#!/bin/bash

append_to_zshrc() {
    local text="$1" zshrc
    local skipNewLine="${2:-0}"

    echo_line "\nAppend \"$text\" to .zshrc"

    if [ -w "$HOME/.zshrc.local" ]; then
        zshrc="$HOME/.zshrc.local"
    else
        zshrc="$HOME/.zshrc"
    fi

    if ! grep -Fqs "$text" "$zshrc"; then
        if [ "$skipNewLine" -eq 1 ]; then
            printf "%s\\n" "$text" >>"$zshrc"
        else
            printf "\\n%s\\n" "$text" >>"$zshrc"
        fi
    fi
}

ensure_correct_ohmyzsh_theme_is_used() {
    local themeFilePath="$1"
    local themeName="$2"
    local zshrc="$HOME/.zshrc"
    local defaultOhMyZSHThemeString='ZSH_THEME="robbyrussell"'
    local desiredOhMyZSHThemeString="ZSH_THEME=\"${themeName}\""

    echo_line "\nEnsure $themeName OhMyZSH theme is used\n"

    ensure_symlink_exists "${themeFilePath}" "${HOME}/.oh-my-zsh/custom/themes/${themeName}.zsh-theme"

    update_file_line_in_situ ${zshrc} "${defaultOhMyZSHThemeString}" "${desiredOhMyZSHThemeString}"
}

ensure_zsh_autosuggestions_are_installed() {
    echo_line "\nEnsure ZSH autosuggestions are installed\n"
    rm -rf ~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
}

ensure_zsh_is_installed() {
    installApplicationHomebrewStyle "zsh" 1
    echo_line "Current shell is $SHELL"
    if [[ "$SHELL" != "/bin/zsh" ]]; then
        # This causes the GitHub Actions pipeline to bork becuase we do not seem
        # to be able to programmatically get around needing to enter a password,
        # so stop exiting on error temporarily...
        set +e
        chsh -s /bin/zsh
        echo_line "Shell is now changed to $SHELL"
        # Then re-enable exiting on error...
        set -e
    fi
}

ensure_ohmyzsh_is_installed() {
    echo_line "\nEnsure OhMyZSH is installed\n"
    rm -rf ~/.oh-my-zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
}

ensure_zsh_correction_is_used() {
    echo_line "\nEnsure ZSH correction is used\n"
    local zshrc="$HOME/.zshrc"
    update_file_line_in_situ ${zshrc} '# ENABLE_CORRECTION="true"' 'ENABLE_CORRECTION="true"'
}

ensure_zsh_completion_waiting_dots_are_used() {
    echo_line "\nEnsure ZSH completion waiting dots are used\n"
    local zshrc="$HOME/.zshrc"
    update_file_line_in_situ ${zshrc} '# COMPLETION_WAITING_DOTS="true"' 'COMPLETION_WAITING_DOTS="true"'
}
