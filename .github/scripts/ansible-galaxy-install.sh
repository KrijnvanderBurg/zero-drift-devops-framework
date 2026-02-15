#!/bin/bash
set -e

echo "Installing Ansible Galaxy requirements..."

if [ -f "requirements.yml" ]; then
  ansible-galaxy collection install -r requirements.yml --force
  ansible-galaxy role install -r requirements.yml --force 2>/dev/null || true
  echo "Galaxy requirements installed successfully."
else
  echo "No requirements.yml found, skipping."
fi
