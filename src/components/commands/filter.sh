#!/bin/bash

include() {
    includeGroupToCheck="$1"

    configFile="$basePath/../.config.json"
    if [ ! -f "$configFile" ]; then
        true
        return
    fi

    if [ $(jq ".includeGroup.$includeGroupToCheck" "$configFile") == false ]; then
        false
    elif [ $(jq ".includeGroup.$includeGroupToCheck" "$configFile") == true ]; then
        true
    elif [ $(jq ".includeGroup.$includeGroupToCheck" "$configFile") == null ]; then
        if [ $(jq .includeAllByDefault "$configFile") == false ]; then
            false
        else
            true
        fi
    fi
    return
}
