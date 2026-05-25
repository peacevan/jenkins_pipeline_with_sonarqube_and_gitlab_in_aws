#!/usr/bin/env bash
set -euo pipefail

# Standardized helper for GitLab CI / local checks
echo "[data/data_gitlab.sh] Running standard checks"

command -v terraform >/dev/null 2>&1 || { echo "terraform not found in PATH"; exit 1; }

echo "terraform fmt (check)"
terraform fmt -check -diff || echo "terraform fmt found differences"

echo "terraform init (no backend)"
terraform init -input=false -backend=false

echo "terraform validate"
terraform validate

if command -v tflint >/dev/null 2>&1; then
	echo "tflint"
	tflint || true
else
	echo "tflint not installed - skipping"
fi

echo "terraform plan - out to tfplan"
terraform plan -out=tfplan -input=false
echo "tfplan ready"

echo "Done. Use tfplan or adapt this script for CI runner specifics."
