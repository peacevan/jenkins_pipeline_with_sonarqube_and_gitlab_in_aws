# Standardized helper for CI/local Terraform checks (idempotent)
#!/usr/bin/env bash
set -euo pipefail

echo "[data/data_jenkins.sh] Starting terraform checks"

command -v terraform >/dev/null 2>&1 || { echo "terraform not found in PATH"; exit 1; }

echo "Running terraform fmt (check)"
terraform fmt -check -diff || echo "terraform fmt found differences"

echo "Initializing Terraform (no remote backend)"
terraform init -input=false -backend=false

echo "Validating Terraform configuration"
terraform validate

if command -v tflint >/dev/null 2>&1; then
	echo "Running tflint"
	tflint || true
else
	echo "tflint not installed - skipping"
fi

echo "Creating execution plan"
terraform plan -out=tfplan -input=false
echo "Plan saved to tfplan"

echo "Done. Review tfplan or run 'terraform apply tfplan' locally when ready."
#!/bin/bash

# Definindo um nome para o host
hostnamectl set-hostname jenkins-server

/bin/bash

sudo apt update
sudo apt install openjdk-11-jre
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins
systemctl status jenkins