#!/bin/bash

additionalCommands() {
    stage="$1"

    configFile="$basePath/../.config.json"
    if [ ! -f "$configFile" ]; then
        return
    fi

    commands=$(jq ".additionalCommands.$stage" "$configFile")
    if [ "$commands" == null ]; then
        echo_heading "There are no additional commands for stage $stage"
    else
        echo_heading "Additional commands for stage $stage"
        echo "${commands}"
        while IFS= read -r command; do
            command="$(eval "echo $command")"
            echo_empty_line
            echo_line "Run $command"
            echo_empty_line
            eval $command
        done <<< "$(echo -e "${commands}" | jq '.[]')"
    fi
}
