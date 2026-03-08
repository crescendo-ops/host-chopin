#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

TARGET="chopin"

BUILD_ATTR="./nix#nixosConfigurations.${TARGET}.config.system.build.toplevel"
BUILD_DATE="$(date -u +%Y%m%dT%H%M%SZ)"
ARTIFACT_DIR="${REPO_ROOT}/images/chopin/artifacts"
CACHE_DIR="${ARTIFACT_DIR}/cache"

mkdir -p "${CACHE_DIR}"

cd "${REPO_ROOT}"

echo "Building system closure for ${BUILD_ATTR}"
SYSTEM_PATH="$(nix build --print-out-paths --no-link "${BUILD_ATTR}")"

echo "Exporting closure to local file cache"
nix copy --to "file://${CACHE_DIR}" "${SYSTEM_PATH}"

{
  echo "target=${TARGET}"
  echo "built_at_utc=${BUILD_DATE}"
  echo "build_attr=${BUILD_ATTR}"
  echo "system_path=${SYSTEM_PATH}"
} > "${ARTIFACT_DIR}/manifest.env"

nix path-info -r "${SYSTEM_PATH}" > "${ARTIFACT_DIR}/closure-paths.txt"
cp "${REPO_ROOT}/scripts/activate-chopin-artifact.sh" "${ARTIFACT_DIR}/activate.sh"

ARCHIVE_PATH="${ARTIFACT_DIR}/${TARGET}-upgrade-${BUILD_DATE}.tar.gz"
tar -C "${ARTIFACT_DIR}" -czf "${ARCHIVE_PATH}" cache manifest.env closure-paths.txt activate.sh

echo
echo "Offline upgrade artifact created:"
echo "  ${ARCHIVE_PATH}"
echo
echo "Tarball contents:"
echo "  cache/                # file-based binary cache"
echo "  manifest.env          # system path and metadata"
echo "  closure-paths.txt     # full closure paths"
echo "  activate.sh           # activation helper to run on target"
