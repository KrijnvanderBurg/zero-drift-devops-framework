#!/bin/bash
plan_file="${1:?Plan file is required}"
output_file="${2:-}"

tofu apply -no-color "$plan_file" 2>&1 | tee "$output_file"
exit_code=${PIPESTATUS[0]}
echo "apply_output_file=${output_file}" >> "$GITHUB_OUTPUT"
exit $exit_code
