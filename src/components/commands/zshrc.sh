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

ensure_correct_ohmyzsh_theme_is_used() {
    local themeFilePath="$1"
    local themeName="$2"
    local zshrc="$HOME/.zshrc"
    local defaultOhMyZSHThemeString='ZSH_THEME="robbyrussell"'
    local desiredOhMyZSHThemeString="ZSH_THEME=\"${themeName}\""

    ensure_symlink_exists "${themeFilePath}" "${HOME}/.oh-my-zsh/custom/themes/${themeName}.zsh-theme"

    update_file_line_in_situ ${zshrc} "${defaultOhMyZSHThemeString}" "${desiredOhMyZSHThemeString}"
}

ensure_zsh_and_zsh_completions_are_installed() {
    brew reinstall zsh zsh-completions
    echo $SHELL
    if [[ "$SHELL" != "/bin/zsh" ]]; then
        chsh -s /bin/zsh
    fi
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    append_to_zshrc "export GIT_USER_NAME=\"$GIT_USER_NAME\""
    append_to_zshrc "export GIT_USER_EMAIL=\"$GIT_USER_EMAIL\"" 1
}

ensure_zshrc_correction_is_used() {
    local zshrc="$HOME/.zshrc"
    update_file_line_in_situ ${zshrc} '# ENABLE_CORRECTION="true"' 'ENABLE_CORRECTION="true"'
}

ensure_zshrc_completion_waiting_dots_are_used() {
    local zshrc="$HOME/.zshrc"
    update_file_line_in_situ ${zshrc} '# COMPLETION_WAITING_DOTS="true"' 'COMPLETION_WAITING_DOTS="true"'
}
