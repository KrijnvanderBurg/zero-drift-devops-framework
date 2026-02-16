# Ansible DevContainer (in development)

A reproducible Ansible development environment that installs Ansible and common helpers, provides VS Code tasks for linting and playbook runs, and installs `pre-commit` hooks inside the container.

## Key features

- Base image: `mcr.microsoft.com/devcontainers/base:ubuntu-24.04`
- `ghcr.io/devcontainers/features/python` with `pipx` (used to install `pre-commit`)
- `onCreateCommand` hooks to install `pre-commit` and run an Ansible installer script (`.github/scripts/ansible-install.sh`)
- VS Code settings for Ansible (`ansible.python.interpreterPath`) and file associations
- VS Code tasks: `ansible lint`, `ansible galaxy install`, `ansible playbook check`, `ansible playbook apply`

## Getting started

1. Open the repository in VS Code.
2. Press `F1` → `Dev Containers: Rebuild and Reopen in Container` and choose the `ansible` configuration.
3. The container will be built and the `onCreateCommand` will run to set up `pre-commit` and (if present) run the included Ansible installer script.

Run `ansible --version` inside the container to verify installation.

## Pre-commit hooks

This DevContainer demonstrates how to enable `pre-commit` hooks inside the container and provides an example config for Ansible playbooks.

- Example pre-commit config: `example.pre-commit-config.yaml` (next to this README). It is a starting point — extend it with project-specific hooks.
- The DevContainer `onCreateCommand` installs `pre-commit` via `pipx` and runs `pre-commit install` so hooks are active in the container shell.
- To run hooks manually inside or outside the container:

```bash
# inside the container (after onCreateCommand)
pre-commit run --all-files

# or locally
pip install pre-commit
pre-commit install
pre-commit run --all-files
```

## VS Code tasks

- `ansible lint` — runs repository's Ansible linting script
- `ansible galaxy install` — installs role dependencies
- `ansible playbook check` — runs playbooks in check/dry-run mode
- `ansible playbook apply` — runs playbooks in apply mode
- `pre-commit run` — (task available if added) runs `pre-commit` across the repository

---

If you want, I can add a `pre-commit install` and/or `pre-commit run` task to the container tasks (so you can run them from the VS Code Tasks UI).