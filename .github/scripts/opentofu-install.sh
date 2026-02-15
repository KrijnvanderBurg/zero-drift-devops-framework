#!/bin/bash
set -e

# Install tofu if not already installed
if ! command -v tofu &> /dev/null; then
    echo "Installing OpenTofu..."

    # Install tooling
    sudo apt-get update
    sudo apt-get install -y apt-transport-https ca-certificates curl gnupg

    # Set up the OpenTofu repository
    sudo install -m 0755 -d /etc/apt/keyrings

    # Download GPG keys with retry logic
    curl --retry 3 --retry-delay 2 --retry-all-errors -fsSL https://get.opentofu.org/opentofu.gpg | sudo tee /etc/apt/keyrings/opentofu.gpg > /dev/null
    curl --retry 3 --retry-delay 2 --retry-all-errors -fsSL https://packages.opentofu.org/opentofu/tofu/gpgkey | sudo gpg --no-tty --batch --dearmor -o /etc/apt/keyrings/opentofu-repo.gpg > /dev/null
    sudo chmod a+r /etc/apt/keyrings/opentofu.gpg /etc/apt/keyrings/opentofu-repo.gpg

    echo \
      "deb [signed-by=/etc/apt/keyrings/opentofu.gpg,/etc/apt/keyrings/opentofu-repo.gpg] https://packages.opentofu.org/opentofu/tofu/any/ any main
deb-src [signed-by=/etc/apt/keyrings/opentofu.gpg,/etc/apt/keyrings/opentofu-repo.gpg] https://packages.opentofu.org/opentofu/tofu/any/ any main" | \
      sudo tee /etc/apt/sources.list.d/opentofu.list > /dev/null
    sudo chmod a+r /etc/apt/sources.list.d/opentofu.list

    # Install OpenTofu
    sudo apt-get update
    sudo apt-get install -y tofu

    # Clean up
    sudo rm -rf /var/lib/apt/lists/*
    hash -r
fi
tofu version
