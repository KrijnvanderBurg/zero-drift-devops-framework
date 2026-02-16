#!/bin/bash
target_path="${1:-$PWD}" && echo "Scanning folder: $target_path"
config_filepath="${2}" && echo "Config file: $config_filepath"

# Install devskim if not already installed
if ! command -v devskim &> /dev/null; then
    echo "Installing devskim..."
    dotnet tool install --global Microsoft.CST.devskim.CLI
fi
echo -n "devskim version: " && devskim --version

devskim analyze --source-code "$target_path" \
  --options-json "$config_filepath" \
  -E