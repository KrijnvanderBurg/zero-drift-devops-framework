#!/bin/bash
output_path="${1:-$PWD}" && echo "output folder: $output_path"

# Install cdktf if not already installed
if ! command -v cdktf &> /dev/null; then
    echo "Installing cdktf..."
    npm install --silent --global cdktf-cli@0.20
fi
echo -n "cdktf version: " && cdktf --version

cdktf synth \
  --output "$output_path"
