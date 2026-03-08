#!/usr/bin/env bash
set -euo pipefail

# Deploy chopin config from control machine using nixos-rebuild.
# Usage:
#   ./scripts/deploy-chopin.sh <switch|boot|test> <target-host> [target]
# Examples:
#   ./scripts/deploy-chopin.sh test root@192.168.1.124
#   ./scripts/deploy-chopin.sh switch root@192.168.1.124
#   ./scripts/deploy-chopin.sh boot root@192.168.1.124

if [ "$#" -lt 2 ]; then
  echo "Usage: $0 <switch|boot|test> <target-host> [target]" >&2
  exit 1
fi

ACTION="$1"
TARGET_HOST="$2"
TARGET="${3:-chopin}"

case "${ACTION}" in
  switch|boot|test) ;;
  *)
    echo "Invalid action: ${ACTION}. Expected switch, boot, or test." >&2
    exit 1
    ;;
esac

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

cd "${REPO_ROOT}"

nix run nixpkgs#nixos-rebuild -- "${ACTION}" \
  --flake "path:${REPO_ROOT}/nix#${TARGET}" \
  --build-host "${TARGET_HOST}" \
  --target-host "${TARGET_HOST}"

if [ "${ACTION}" = "boot" ]; then
  echo
  echo "Boot profile activated. Reboot target to apply kernel/boot changes:"
  echo "  ssh ${TARGET_HOST} reboot"
fi
