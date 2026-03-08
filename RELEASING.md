# Releasing

## PR Title Convention

This repository uses Conventional Commit style PR titles because squash merge commit messages drive release automation.

Examples:

- `feat(chopin): add rollback snapshot metadata`
- `fix(ci): include artifact checksums`
- `chore: update dependencies`

## Versioning Model

- Stable releases: `vMAJOR.MINOR.PATCH` (Release Please)
- Beta prereleases: `vMAJOR.MINOR.PATCH-beta.N`

## Automated Flows

- `build-chopin-upgrade-artifact.yml`
  - Runs on pull requests and manual dispatch
  - Builds and uploads artifact for validation
- `release-please.yml`
  - Runs on push to `main`
  - Opens/updates release PRs from commit history
  - Creates stable GitHub releases when release PRs are merged
  - Creates and publishes a beta prerelease with `vX.Y.Z-beta.N`
- `publish-release-assets.yml`
  - Runs when a GitHub release is published (stable or beta)
  - Rebuilds and uploads release assets

## Repository Settings

Recommended GitHub settings for `main`:

- Squash merge only
- Pull request required before merge
- Required status checks
- Linear history enabled
- Force pushes disabled
- Branch deletion disabled
