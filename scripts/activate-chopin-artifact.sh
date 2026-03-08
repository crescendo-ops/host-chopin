#!/usr/bin/env bash
set -euo pipefail

# Activate unpacked chopin upgrade artifact on target host.
# Run this in the extracted artifact directory containing cache/ and manifest.env.

if [ ! -f manifest.env ]; then
  echo "manifest.env not found in current directory." >&2
  exit 1
fi

if [ ! -d cache ]; then
  echo "cache/ directory not found in current directory." >&2
  exit 1
fi

SYSTEM_PATH="$(grep '^system_path=' manifest.env | cut -d= -f2-)"

if [ -z "${SYSTEM_PATH}" ]; then
  echo "system_path is missing in manifest.env" >&2
  exit 1
fi

echo "Importing system closure from local cache"
sudo nix copy --from "file://$PWD/cache" "${SYSTEM_PATH}"

echo "Setting system profile"
sudo nix-env -p /nix/var/nix/profiles/system --set "${SYSTEM_PATH}"

echo "Switching configuration"
sudo "${SYSTEM_PATH}/bin/switch-to-configuration" switch
