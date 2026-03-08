# chopin

Single-host NixOS repository for the `chopin` machine.

## Contents

- `images/chopin`: upgrade artifact build scripts
- `nix/hosts/chopin`: machine-specific NixOS config
- `nix/modules/nixos`: reusable local modules used by `chopin`
- `ARCHITECTURE.md`: repository layout and design notes

## CI

GitHub Actions workflow: `.github/workflows/build-chopin-upgrade-artifact.yml`
