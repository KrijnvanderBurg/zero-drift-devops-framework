#!/bin/bash
set -e

echo "Running ansible-lint..."
ansible-lint site.yml
