# Agent Working Conventions

## Branch Naming
- Use semantic branch names with one of these prefixes: `fix/`, `feat/`, `perf/`, `deps/`, `revert/`, `docs/`, `style/`, `chore/`, `refactor/`, `test/`, `build/`, `ci/`.
- Keep names descriptive and concise.

## Pull Request Naming
- PR titles must follow semantic commit style: `<type>(<scope>): <description>`.
- Allowed types include: `feat`, `fix`, `perf`, `deps`, `revert`, `docs`, `style`, `chore`, `refactor`, `test`, `build`, `ci`.
- Scope and description must be explicit and narrowly targeted.
- Avoid broad scopes like `nix` when a more specific scope exists (for example: `ops-tools`, `vyos-router`, `ci`).
- Prefer descriptions that name the concrete change (for example: `add python3 to ops-tools systemPackages`).
- This repository builds an operating system, so changes that add or expand OS capabilities (packages, modules, services, system behavior) should use `feat`.
- Use `chore` only for maintenance that does not change OS capabilities or runtime behavior (for example: formatting, internal tooling, CI-only maintenance, non-functional cleanup).

## Commit Subject Naming
- Commit subjects must be plain language and describe exactly what was done.
- Do not use semantic tags in commit subjects (no `feat(...)`, `fix(...)`, `chore(...)`, etc.).
- Only PR titles use semantic tagging.
- Prefer short imperative descriptions (for example: `Add python3 to ops-tools systemPackages`).
