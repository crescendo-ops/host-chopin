# chopin

Single-host NixOS repository for the `chopin` machine.

## Contents

- `images/chopin`: upgrade artifact build scripts
- `nix/default.nix`: single host configuration entrypoint
- `nix/{disko,hardware-configuration,network}.nix`: host-specific hardware and network inputs
- `nix/modules`: reusable local modules used by `chopin`
- `nix/flake.nix` and `nix/flake.lock`: flake definition and lock file
- `ARCHITECTURE.md`: repository layout and design notes

## CI

GitHub Actions workflow: `.github/workflows/build-chopin-upgrade-artifact.yml`
