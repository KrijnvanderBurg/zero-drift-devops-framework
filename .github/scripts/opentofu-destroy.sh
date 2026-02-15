#!/bin/bash
set -e

output_file="destroy-output.txt"

tofu destroy -auto-approve -no-color 2>&1 | tee "$output_file"
exit_code=${PIPESTATUS[0]}
echo "destroy_output_file=${output_file}" >> "$GITHUB_OUTPUT"
exit $exit_code
