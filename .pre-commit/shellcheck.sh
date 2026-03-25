#!/bin/bash

set -e

files=("$@")
fixed=0

for file in "${files[@]}"; do
    diff=$(shellcheck --format=diff "$file" 2>/dev/null || true)
    if [ -n "$diff" ]; then
        echo "$diff" | patch -p0
        fixed=1
    fi
done

if [ "$fixed" -eq 1 ]; then
    echo ""
    echo "shellcheck applied fixes to one or more files. Review and re-stage the changes."
    exit 1
fi

shellcheck "${files[@]}"
