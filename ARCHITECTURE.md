# Architecture

This repository manages one NixOS host: `chopin`.

## Layout

- `flake.nix`: single `nixosConfigurations.chopin` entrypoint
- `nix/hosts/chopin`: host-specific configuration and hardware/network files
- `nix/modules/nixos`: local modules composed by `nix/hosts/chopin/default.nix`
- `images/chopin`: offline upgrade artifact build logic
- `.github/workflows`: CI, prerelease, and release automation

## Design choices

- Single-host scope: no multi-host abstraction layer.
- Host config imports modules directly from `nix/modules/nixos`.
- Upgrade artifacts are written to `images/chopin/artifacts` for predictable CI pickup.
