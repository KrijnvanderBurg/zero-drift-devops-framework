#!/bin/bash
inventory="${INVENTORY:?Inventory path is required}"
mode="${MODE:-check}"
output_file="${OUTPUT_FILE:-}"

if [ "$mode" = "check" ]; then
  echo "Running ansible-playbook in check mode..."
  ansible-playbook -i "$inventory" site.yml --check --diff 2>&1 | tee "$output_file"
  exitcode=${PIPESTATUS[0]}
else
  echo "Running ansible-playbook in apply mode..."
  ansible-playbook -i "$inventory" site.yml 2>&1 | tee "$output_file"
  exitcode=${PIPESTATUS[0]}
fi

echo "playbook_output_file=$output_file" >> "$GITHUB_OUTPUT"
exit $exitcode
