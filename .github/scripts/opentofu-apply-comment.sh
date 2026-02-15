#!/bin/bash
apply_output_file="${1:-}"
environment="${2:-dev}"
target_path="${3:-./environments/dev}"
apply_status="${4:-success}"

[[ -z "$apply_output_file" || ! -f "$apply_output_file" ]] && echo "Error: Valid apply output file required" && exit 1

apply_output=$(cat "$apply_output_file")

# Truncate if too long (GitHub comment limit is 65536 chars)
[[ ${#apply_output} -gt 60000 ]] && apply_output="${apply_output:0:60000}

... (truncated)"

# Set status emoji and text
if [[ "$apply_status" == "success" ]]; then
  status_emoji="✅"
  status_text="Successfully Applied"
else
  status_emoji="❌"
  status_text="Apply Failed"
fi

# Build and output comment body
cat <<EOF >> "$GITHUB_OUTPUT"
comment_body<<ENDOFCOMMENT
## ${status_emoji} OpenTofu Apply - ${environment}

**Status:** ${status_text}
**Environment:** \`${environment}\`
**Directory:** \`${target_path}\`

<details>
<summary>Show Apply Output</summary>

\`\`\`hcl
${apply_output}
\`\`\`

</details>

*Applied by @${GITHUB_ACTOR} in commit ${GITHUB_SHA}*
ENDOFCOMMENT
EOF
