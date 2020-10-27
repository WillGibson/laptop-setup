#!/bin/bash

echo_heading() {
    echo -e "\n\033[48;32;1m# $1 #\033[0m"
}

echo_line() {
    echo -e "\033[48;34;2m$1\033[0m"
}

ensure_symlink_exists() {
    realPath="$1"
    linkPath="$2"

    rm -f "${linkPath}"
    ln -s ${realPath} ${linkPath}

    echo "Created symlink $realPath -> $linkPath"
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
