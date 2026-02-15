#!/bin/bash

echo "Checking formatting..." && tofu fmt -check -recursive
echo "Validating configuration..." && tofu validate
