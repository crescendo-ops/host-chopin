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

## Update From Control Machine

Repo only needs to exist on the control machine (for example your Mac).

Set once per shell:

```bash
TARGET=chopin
TARGET_HOST=root@192.168.1.124
```

```bash
nix run nixpkgs#nixos-rebuild -- switch \
  --flake "path:$PWD/nix#$TARGET" \
  --build-host "$TARGET_HOST" \
  --target-host "$TARGET_HOST"
```

Note: `switch` is not sufficient for kernel boot parameter changes (for example
`amd_iommu=on` / `iommu=pt`). For those, use `boot` and reboot the target:

```bash
nix run nixpkgs#nixos-rebuild -- boot \
  --flake "path:$PWD/nix#$TARGET" \
  --build-host "$TARGET_HOST" \
  --target-host "$TARGET_HOST"

ssh "$TARGET_HOST" reboot
```

Safer rollout option first (remote):

```bash
nix run nixpkgs#nixos-rebuild -- test \
  --flake "path:$PWD/nix#$TARGET" \
  --build-host "$TARGET_HOST" \
  --target-host "$TARGET_HOST"
```

`--build-host root@...` is the `nixos-rebuild` equivalent of `--build-on remote`.

## CI and Release

- PR and manual artifact build: `.github/workflows/build-chopin-upgrade-artifact.yml`
- Beta prerelease publish on `main`: `.github/workflows/prerelease-beta.yml`
- Stable release automation: `.github/workflows/release-please.yml`
- Stable release asset upload: `.github/workflows/publish-release-assets.yml`

Release policy and merge requirements are documented in `RELEASING.md`.
