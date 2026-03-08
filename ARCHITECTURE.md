# Architecture

This repository manages one NixOS host: `chopin`.

## Layout

- `nix/flake.nix`: single `nixosConfigurations.chopin` entrypoint
- `nix/default.nix`: host composition root
- `nix/{disko,hardware-configuration,network}.nix`: host-specific hardware/network files
- `nix/hardware.md`: host hardware notes
- `nix/modules`: local modules composed by `nix/default.nix`
- `images/chopin`: offline upgrade artifact build logic
- `.github/workflows`: CI, prerelease, and release automation

## Design choices

- Single-host scope: no multi-host abstraction layer.
- Host config imports modules directly from `nix/modules`.
- Upgrade artifacts are written to `images/chopin/artifacts` for predictable CI pickup.
