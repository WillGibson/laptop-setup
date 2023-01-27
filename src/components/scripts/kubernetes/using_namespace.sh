#!/bin/bash

namespace="$(kubectl config view --minify --output 'jsonpath={..namespace}'; echo)"

if [ -n "${namespace}" ]; then
    echo -e "\nUsing namespace $(kubectl config view --minify --output 'jsonpath={..namespace}'; echo)"
fi
