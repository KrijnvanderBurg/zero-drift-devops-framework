# OpenTofu DevContainer (in development)

A lightweight, reproducible Infrastructure-as-Code development environment focused on OpenTofu (an open-source Terraform alternative). It bundles the CLI, common cloud tooling, and convenience scripts to make local development and validation fast and consistent.

## Why use this DevContainer?

- Minimal setup: the container installs and configures required tooling so contributors don't need to manage local OpenTofu or CLI versions.
- Reproducible tasks: VS Code tasks and scripts match CI pipelines so local results mirror CI checks.
- Security & validation: built-in hooks and lint/validation tasks help catch issues early.

**Status:** under active development — basic flows are ready, and features are incrementally added.

## Key features included

- Base image: `mcr.microsoft.com/devcontainers/base:ubuntu-24.04`
- `ghcr.io/devcontainers/features/azure-cli` (Azure CLI available)
- `ghcr.io/devcontainers/features/python` with `pipx` (used to install `pre-commit` in the container)
- `onCreateCommand` scripts to install `pre-commit` and `opentofu`
- Preconfigured VS Code tasks for `pre-commit`, and `opentofu init`, `opentofu lint`, `opentofu plan`, `opentofu apply`
- Editor settings for Terraform files: default formatter, format-on-save, and explicit Terraform formatting actions

## Getting started

1. Open the repository in VS Code.
2. Press `F1` → `Dev Containers: Rebuild and Reopen in Container` and choose the `opentofu` configuration.
3. The container will be built and the `onCreateCommand` will run to set up `pre-commit` and (if present) run the included OpenTofu installer script.

Run `opentofu version` inside the container to verify installation.

## Common tasks (VS Code)

- `pre-commit run` — runs pre-commit on all files.
- `opentofu init` — initializes the workspace (task calls `.github/scripts/opentofu-init.sh`).
- `opentofu lint` — runs configured lint checks.
- `opentofu plan` — runs `opentofu plan` (depends on `opentofu init`).
- `opentofu apply` — runs `opentofu apply` via project script.

## Pre-commit hooks

This DevContainer demonstrates how to enable `pre-commit` hooks inside the container and provides an example config for OpenTofu/Terraform files.

- Example pre-commit config: `example.pre-commit-config.yaml` (next to this README). It includes common repository hooks plus local hooks that run `tofu fmt` and `tofu validate`.
- The DevContainer `onCreateCommand` will attempt to install `pre-commit` via `pipx` and run `pre-commit install` so hooks are active in the container shell.
- To run hooks manually inside or outside the container:

```bash
# inside the container (after install)
pre-commit run --all-files

# or locally
pip install pre-commit
pre-commit install
pre-commit run --all-files
```

Adjust or extend the example hooks for your project; local `repo: local` hooks in the example call `tofu` CLI commands for formatting/validation.
