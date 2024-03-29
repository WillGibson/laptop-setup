#!/bin/bash

append_to_zshrc() {
    local text="$1"
    local skipNewLine="${2:-0}"

    append_text_to_file ~/.zshrc "$text" $skipNewLine
}

append_to_zshrc_parts() {
    local text="$1"
    local skipNewLine="${2:-0}"

    append_text_to_file ~/.zshrc_parts_from_laptop_setup.sh "$text" $skipNewLine
}

ensure_correct_ohmyzsh_theme_is_used() {
    local themeFilePath="$1"
    local themeName="$2"
    local zshrc="$HOME/.zshrc"
    local defaultOhMyZSHThemeString='ZSH_THEME="robbyrussell"'
    local desiredOhMyZSHThemeString="ZSH_THEME=\"${themeName}\""

    echo_line "\nEnsure $themeName OhMyZSH theme is used\n"

    ensure_symlink_exists "${themeFilePath}" "${HOME}/.oh-my-zsh/custom/themes/${themeName}.zsh-theme"

    update_file_line_in_situ "${zshrc}" "${defaultOhMyZSHThemeString}" "${desiredOhMyZSHThemeString}"
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
        # This causes the GitHub Actions pipeline to bork because we do not seem
        # to be able to programmatically get around needing to enter a password,
        # so don't exit on error...
        run_command_but_dont_exit_on_error "chsh -s /bin/zsh && echo_line \"Shell is now changed to \$SHELL\""
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
    update_file_line_in_situ "${zshrc}" '# ENABLE_CORRECTION="true"' 'ENABLE_CORRECTION="true"'
}

ensure_zsh_correction_is_not_used() {
    echo_line "\nEnsure ZSH correction is used\n"
    local zshrc="$HOME/.zshrc"
    update_file_line_in_situ "${zshrc}" '# ENABLE_CORRECTION="true"' 'ENABLE_CORRECTION="true"'
}

ensure_zsh_completion_waiting_dots_are_used() {
    echo_line "\nEnsure ZSH completion waiting dots are used\n"
    local zshrc="$HOME/.zshrc"
    update_file_line_in_situ "${zshrc}" '# COMPLETION_WAITING_DOTS="true"' 'COMPLETION_WAITING_DOTS="true"'
}
