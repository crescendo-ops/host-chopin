#!/usr/bin/env bash
set -euo pipefail

# Run nixos-anywhere from control machine to install/reinstall chopin.
# Usage:
#   ./scripts/install-chopin-anywhere.sh root@192.168.1.124

if [ "$#" -lt 1 ]; then
  echo "Usage: $0 <target-host>" >&2
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
TARGET_HOST="$1"
TARGET="chopin"

cd "${REPO_ROOT}"

nix run github:nix-community/nixos-anywhere -- \
  --build-on remote \
  --flake "path:${REPO_ROOT}/nix#${TARGET}" \
  --generate-hardware-config nixos-generate-config "${REPO_ROOT}/nix/hardware-configuration.nix" \
  --target-host "${TARGET_HOST}"
