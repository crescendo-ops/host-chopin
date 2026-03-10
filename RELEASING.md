# Releasing

## PR Title Convention

This repository uses Conventional Commit style PR titles because squash merge commit messages drive release automation.

Examples:

- `feat(chopin): add rollback snapshot metadata`
- `fix(ci): include artifact checksums`
- `deps(nix): update dependency pins`

## Versioning Model

- Stable releases: `vMAJOR.MINOR.PATCH` (Release Please)
- Beta prereleases: `vMAJOR.MINOR.PATCH-beta.N`

## Automated Flows

- `nix-ci.yml`
  - Runs on pull requests (including draft PR updates)
  - Checks Nix formatting and runs flake checks without building outputs
- `release-pr-title-lint.yml`
  - Runs on pull request events
  - Enforces semantic PR titles required by release automation
  - Allowed types: `feat`, `fix`, `perf`, `deps`, `revert`, `docs`, `style`, `chore`, `refactor`, `test`, `build`, `ci`
- `release-please.yml`
  - Runs on push to `main`
  - Opens/updates release PRs from commit history
  - Creates stable GitHub releases when release PRs are merged
  - Used with beta publish flow for prerelease tags
- `release-publish-beta.yml`
  - Runs on manual dispatch
  - Creates and publishes a beta prerelease with `vX.Y.Z-beta.N`
- `release-publish-assets.yml`
  - Runs on manual dispatch and when a GitHub release is published (stable or beta)
  - Builds and uploads validation artifacts on manual runs
  - Rebuilds and uploads release assets when a release tag is provided

## Release Notes Inclusion

- `release-please-config.json` explicitly includes all allowed commit types in `changelog-sections`.
- Result: each allowed type (`feat`, `fix`, `perf`, `deps`, `revert`, `docs`, `style`, `chore`, `refactor`, `test`, `build`, `ci`) both:
  - appears in release notes
  - counts as user-facing for opening/updating release PRs

## Repository Settings

Recommended GitHub settings for `main`:

- Squash merge only
- Pull request required before merge
- Required status checks
- Linear history enabled
- Force pushes disabled
- Branch deletion disabled
