#!/bin/bash
target_path="${1:-$PWD}" && echo "Scanning folder: $target_path"
config_filepath="${2}" && echo "Config file: $config_filepath"

# Install isort if not already installed
if ! command -v isort &> /dev/null; then
    echo "Installing isort..."
    pip install isort --quiet
fi
echo -n "isort version: " && isort --version

isort --check-only "$target_path" \
  --settings-path "$config_filepath" \
  --diff
