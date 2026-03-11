#!/bin/bash

ensure_terminal_stuff_is_installed() {
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
}
