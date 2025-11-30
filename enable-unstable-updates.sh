#!/bin/bash

set -xeuo pipefail

datestamp=$(date +%Y%m%d%H%M%S)

files=(
    /usr/sbin/debsecan-apt-priority
    /etc/apt/preferences.d/unstable-security-packages
)

for f in "${files[@]}"; do
    if [ -f "$f" ]; then
        cp "$f" "${f}.bak.${datestamp}"
    fi
done

apt install -y debsecan

cp -v ./debsecan-apt-priority /usr/sbin/debsecan-apt-priority
chmod 755 /usr/sbin/debsecan-apt-priority
cp -v ./99debsecan /etc/apt/apt.conf.d/
ln -sf /var/lib/debsecan/apt_preferences /etc/apt/preferences.d/unstable-security-packages

apt update
