#!/bin/bash
set -e

# Install ansible if not already installed
if ! command -v ansible &> /dev/null; then
    pipx install --include-deps ansible
fi

# Inject ansible-lint if not available
if ! command -v ansible-lint &> /dev/null; then
    pipx inject --include-apps ansible ansible-lint
fi

ansible --version
ansible-lint --version
