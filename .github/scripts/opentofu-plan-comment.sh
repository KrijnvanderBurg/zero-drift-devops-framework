#!/bin/bash
plan_file="${1:-}"
environment="${2:-dev}"
target_path="${3:-./environments/dev}"

[[ -z "$plan_file" || ! -f "$plan_file" ]] && echo "Error: Valid plan file required" && exit 1

plan_output=$(cat "$plan_file")

# Truncate if too long (GitHub comment limit is 65536 chars)
[[ ${#plan_output} -gt 60000 ]] && plan_output="${plan_output:0:60000}

... (truncated)"

# Build and output comment body
cat <<EOF >> "$GITHUB_OUTPUT"
comment_body<<ENDOFCOMMENT
## OpenTofu Plan

**Environment:** \`${environment}\`
**Directory:** \`${target_path}\`

<details>
<summary>Show Plan Output</summary>

\`\`\`hcl
${plan_output}
\`\`\`

</details>

*Triggered by @${GITHUB_ACTOR} in commit ${GITHUB_SHA}*
ENDOFCOMMENT
EOF
