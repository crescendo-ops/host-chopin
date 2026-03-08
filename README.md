# host-chopin

Single-host NixOS repository for `chopin`.

## Repository Layout

- `nix/flake.nix` and `nix/flake.lock`: flake entrypoint and lock file
- `nix/default.nix`: host composition root for `chopin`
- `nix/disko.nix`, `nix/hardware-configuration.nix`, `nix/network.nix`: host-specific inputs
- `nix/modules/*.nix`: reusable local modules
- `scripts/build-chopin-upgrade-artifact.sh`: build offline upgrade artifact
- `scripts/activate-chopin-artifact.sh`: activate unpacked artifact on target
- `scripts/install-chopin-anywhere.sh`: install/reinstall via `nixos-anywhere`
- `scripts/deploy-chopin.sh`: remote `nixos-rebuild` (`switch|boot|test`)
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
./activate.sh
```

## Install/Reinstall with nixos-anywhere

From repository root:

```bash
./scripts/install-chopin-anywhere.sh root@<target-ip-or-dns>
```

## Update From Control Machine

Repo only needs to exist on the control machine (for example your Mac).

```bash
./scripts/deploy-chopin.sh test root@192.168.1.124
./scripts/deploy-chopin.sh switch root@192.168.1.124
```

Note: `switch` is not sufficient for kernel boot parameter changes (for example
`amd_iommu=on` / `iommu=pt`). For those, use `boot` and reboot the target:

```bash
./scripts/deploy-chopin.sh boot root@192.168.1.124
ssh root@192.168.1.124 reboot
```

`deploy-chopin.sh` uses `--build-host` and `--target-host` on the same remote host.

## CI and Release

- PR and manual artifact build: `.github/workflows/build-chopin-upgrade-artifact.yml`
- Beta prerelease publish on `main`: `.github/workflows/prerelease-beta.yml`
- Stable release automation: `.github/workflows/release-please.yml`
- Stable release asset upload: `.github/workflows/publish-release-assets.yml`

Release policy and merge requirements are documented in `RELEASING.md`.
