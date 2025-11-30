#!/bin/bash

set -xeuo pipefail

datestamp=$(date +%Y%m%d%H%M%S)

declare -A files=(
    ["./20listchanges"]="/etc/apt/apt.conf.d/20listchanges"
)

for f in "${!files[@]}"; do
    if [ -f "${files[$f]}" ]; then
        cp "${files[$f]}" "${files[$f]}.bak.${datestamp}"
    fi
    cp -v "$f" "${files[$f]}"
done

apt update
apt install apt-listchanges
