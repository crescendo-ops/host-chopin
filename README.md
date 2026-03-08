# host-chopin

Single-host NixOS repository for `chopin`.

## Repository Layout

- `nix/flake.nix` and `nix/flake.lock`: flake entrypoint and lock file
- `nix/default.nix`: host composition root for `chopin`
- `nix/disko.nix`, `nix/hardware-configuration.nix`, `nix/network.nix`: host-specific inputs
- `nix/modules/*.nix`: reusable local modules
- `scripts/build-chopin-upgrade-artifact.sh`: offline upgrade artifact builder
- `images/chopin/artifacts/`: generated build outputs (gitignored)
- `hardware.md`: hardware notes

## Build Offline Upgrade Artifact

From repository root:

```bash
./scripts/build-chopin-upgrade-artifact.sh
```

This builds `./nix#nixosConfigurations.chopin.config.system.build.toplevel` and produces:

- `images/chopin/artifacts/chopin-upgrade-<timestamp>.tar.gz`
- `images/chopin/artifacts/manifest.env`
- `images/chopin/artifacts/closure-paths.txt`

## Apply Upgrade On Target

1. Copy `images/chopin/artifacts/chopin-upgrade-<timestamp>.tar.gz` to `chopin`.
2. On `chopin`:

```bash
tar -xzf chopin-upgrade-<timestamp>.tar.gz
sudo nix copy --from "file://$PWD/cache" "$(grep '^system_path=' manifest.env | cut -d= -f2-)"
sudo nix-env -p /nix/var/nix/profiles/system --set "$(grep '^system_path=' manifest.env | cut -d= -f2-)"
sudo "$(grep '^system_path=' manifest.env | cut -d= -f2-)/bin/switch-to-configuration" switch
```

## Install/Reinstall with nixos-anywhere

From repository root:

```bash
nix run github:nix-community/nixos-anywhere -- \
  --build-on remote \
  --flake "path:$PWD/nix#chopin" \
  --generate-hardware-config nixos-generate-config ./nix/hardware-configuration.nix \
  --target-host root@<target-ip-or-dns>
```

## CI and Release

- PR and manual artifact build: `.github/workflows/build-chopin-upgrade-artifact.yml`
- Beta prerelease publish on `main`: `.github/workflows/prerelease-beta.yml`
- Stable release automation: `.github/workflows/release-please.yml`
- Stable release asset upload: `.github/workflows/publish-release-assets.yml`

Release policy and merge requirements are documented in `RELEASING.md`.
