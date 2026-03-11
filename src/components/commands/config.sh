#!/bin/bash

: "${basePath:=}"

ensure_config_file_exists() {
    if [ ! -f "$basePath/../.config.json" ]; then
        echo_line "\nERROR: Please create a .config.json file in the root of this project to use the include command.\n"
        exit 1
    fi
}

include() {
    includeGroupToCheck="$1"

    configFile="$basePath/../.config.json"

    if [ "$(jq ".includeGroup.$includeGroupToCheck" "$configFile")" == false ]; then
        false
    elif [ "$(jq ".includeGroup.$includeGroupToCheck" "$configFile")" == true ]; then
        true
    elif [ "$(jq ".includeGroup.$includeGroupToCheck" "$configFile")" == null ]; then
        if [ "$(jq .includeAllByDefault "$configFile")" == false ]; then
            false
        else
            true
        fi
    fi
    return
}
