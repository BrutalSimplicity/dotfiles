#!/usr/bin/env bash

set -euo pipefail
set -x

if [ -z "${1:-}" ]; then
    printf "USAGE: create-macos-installer-iso.sh <path_to_installer> <iso_dest>\n"
    printf "err: no installer path specified"
    exit 1
fi
if [ -z "${2:-}" ]; then
    printf "USAGE: create-macos-installer-iso.sh <path_to_installer> <iso_dest>\n"
    printf "err: no iso destination specified"
    exit 1
fi
path_to_installer="$1"
iso_dest="$2"

# create empty disk image as destination copy installer files
sudo hdiutil create -size 15g -o /tmp/macos-install -volname macos -layout SPUD -fs HFS+J

# mount the image since `createinstallmedia` expects a volume
sudo hdiutil attach /tmp/macos-install.dmg -noverify -mountpoint /Volumes/macos-install

# run `createinstallmedia` from the installer package to copy installation files to the volume
sudo "$path_to_installer/Contents/Resources/createinstallmedia" --volume /Volumes/macos-install --nointeraction

# detach the volume
hdiutil detach "$(find /Volumes -maxdepth 1 -iname 'install macos*')"

# convert the dmg into cdr (iso equivalent)
hdiutil convert /tmp/macos-install.dmg -format UDTO -o /tmp/macos-install.cdr

# rename to iso
mv /tmp/macos-install.cdr /tmp/macos-install.iso

# copy final iso to the destination
cp /tmp/macos-install.iso "$iso_dest"

# cleanup
sudo rm /tmp/macos-install.*
