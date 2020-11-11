#!/bin/bash

additionalCommands() {
    stage="$1"

    echo_heading "Additional commands for stage $stage"

    configFile="$basePath/../.config.json"
    if [ ! -f "$configFile" ]; then
        return
    fi

    commands=$(jq ".additionalCommands.$stage" "$configFile")
    if [ "$commands" != null ]; then
        for base64Command in $(jq -r '.[] | @base64' <<< "$commands"); do
            command=$(echo "$base64Command"  | base64 --decode)
            echo_empty_line
            echo_line "Run \"$command\""
            echo_empty_line
            $command
        done
    fi
}
