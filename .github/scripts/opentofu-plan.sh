#!/bin/bash
var_file="${1:-}"
plan_binary_file="${2:?Plan binary file path is required}"
plan_text_file="${3:?Plan text file is required}"

tofu plan -no-color -out="$plan_binary_file" ${var_file:+-var-file="$var_file"} 2>&1 | tee "$plan_text_file"
exitcode=${PIPESTATUS[0]}

echo "plan_text_file=$plan_text_file" >> "$GITHUB_OUTPUT"
echo "plan_binary_file=$plan_binary_file" >> "$GITHUB_OUTPUT"

exit $exitcode
