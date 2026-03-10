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

## Local Pre-commit

Install `pre-commit` (Python package), then install and run hooks from repo root:

```bash
pipx install pre-commit
pre-commit install
pre-commit run --all-files
```

## Commit and PR Title Convention

- Use semantic format with mandatory scope: `<type>(<scope>): <description>`.
- Optional breaking marker is supported: `<type>(<scope>)!: <description>`.
- Allowed types: `fix`, `feat`, `chore`, `docs`, `refactor`, `test`, `ci`, `build`, `perf`.
- Examples: `fix(ci): preserve multiline release notes`, `feat(nix): add host module`.

## CI and Release

- PR Nix checks (format + flake evaluation): `.github/workflows/nix-ci.yml`
- PR title semantic validation for release automation: `.github/workflows/release-pr-title-lint.yml`
- Stable release automation on `main`: `.github/workflows/release-please.yml`
- Beta prerelease publish (manual): `.github/workflows/release-publish-beta.yml`
- Artifact build and release asset upload (manual, stable + beta): `.github/workflows/release-publish-assets.yml`

Release policy and merge requirements are documented in `RELEASING.md`.
