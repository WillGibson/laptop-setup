#!/bin/bash

append_text_to_file() {
    filePath="$1"
    local text="$2"
    local skipNewLine="${3:-0}"

    echo_line "\nAppend \"$text\" to $filePath"

    if ! grep -Fqs "$text" "$filePath"; then
        if [ "$skipNewLine" -eq 1 ]; then
            printf "%s\\n" "$text" >>"$filePath"
        else
            printf "\\n%s\\n" "$text" >>"$filePath"
        fi
    fi
}

echo_heading() {
    echo -e "\n\033[48;32;1m# $1 #\033[0m"
}

echo_line() {
    echo -e "\033[48;33;2m$1\033[0m"
}

echo_empty_line() {
    echo ""
}

ensure_symlink_exists() {
    realPath="$1"
    linkPath="$2"

    rm -f "${linkPath}"
    ln -s ${realPath} ${linkPath}

    echo "Created symlink $realPath -> $linkPath"
}

run_command_but_dont_exit_on_error() {
    command="$1"

    set +e; $command; set -e
}

update_file_line_in_situ() {
    filePath="$1"
    defaultLine="$2"
    desiredLine="$3"

    echo_line "\nReplace \"$defaultLine\" with \"$desiredLine\" in \"$filePath\""

    if grep -Fqsx "${defaultLine}" "${filePath}" && ! grep -Fqsx "${desiredLine}" "${filePath}"; then
        find "${filePath}" -type f -exec \
            sed -i '' -e "s/${defaultLine}/${desiredLine}/g" {} \;
    fi
}
