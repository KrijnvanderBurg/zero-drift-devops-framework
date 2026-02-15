#!/bin/bash
set -e

echo "Initializing OpenTofu with remote backend configuration..."
echo "Accessing: ${RESOURCE_GROUP_NAME}/${STORAGE_ACCOUNT_NAME}/${CONTAINER_NAME}/${STATE_KEY}"

tofu init \
  -backend-config="storage_account_name=${STORAGE_ACCOUNT_NAME}" \
  -backend-config="resource_group_name=${RESOURCE_GROUP_NAME}" \
  -backend-config="container_name=${CONTAINER_NAME}" \
  -backend-config="key=${STATE_KEY}"
