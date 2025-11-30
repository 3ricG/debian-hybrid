#!/bin/bash

set -xeuo pipefail

datestamp=$(date +%Y%m%d%H%M%S)

declare -A files=(
    ["./00default-release"]="/etc/apt/apt.conf.d/00default-release"
    ["./default-priority"]="/etc/apt/preferences.d/default-priority"
    ["./sources.list"]="/etc/apt/sources.list"
)

for f in "${!files[@]}"; do
    if [ -f "${files[$f]}" ]; then
        cp "${files[$f]}" "${files[$f]}.bak.${datestamp}"
    fi
    cp -v "$f" "${files[$f]}"
done

apt update
