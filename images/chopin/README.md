# Chopin Upgrade Artifact

This directory contains a script to build an offline upgrade artifact for an existing `chopin` host.

## Script

From repository root:

```bash
./images/chopin/build.sh
```

What it does:

1. Builds `.#nixosConfigurations.chopin.config.system.build.toplevel`
2. Exports the closure into `images/chopin/artifacts/cache`
3. Writes metadata:
   - `images/chopin/artifacts/manifest.env`
   - `images/chopin/artifacts/closure-paths.txt`
4. Creates a tarball:
   - `images/chopin/artifacts/chopin-upgrade-<timestamp>.tar.gz`

`images/chopin/artifacts/` is gitignored.

## Upgrade an existing chopin

1. Build artifact on a builder machine:

   ```bash
   ./images/chopin/build.sh
   ```

2. Copy `images/chopin/artifacts/chopin-upgrade-<timestamp>.tar.gz` to `chopin`.

3. On `chopin`, unpack:

   ```bash
   tar -xzf chopin-upgrade-<timestamp>.tar.gz
   ```

4. Import closure and activate:

   ```bash
   sudo nix copy --from "file://$PWD/cache" "$(grep '^system_path=' manifest.env | cut -d= -f2-)"
   sudo nix-env -p /nix/var/nix/profiles/system --set "$(grep '^system_path=' manifest.env | cut -d= -f2-)"
   sudo "$(grep '^system_path=' manifest.env | cut -d= -f2-)/bin/switch-to-configuration" switch
   ```

## GitHub Actions

Manual workflow:

- `.github/workflows/build-chopin-upgrade-artifact.yml`

Run it with **Actions -> Build Chopin Upgrade Artifact -> Run workflow**.
The workflow uploads the generated `chopin-upgrade-<timestamp>.tar.gz` as an artifact.
