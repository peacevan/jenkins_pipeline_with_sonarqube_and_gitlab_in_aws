#!/usr/bin/env bash
set -euo pipefail

# Standardized helper to run SonarQube analysis locally or in CI
echo "[data/data_sonarqube.sh] Running SonarQube scanner (placeholder)"

if ! command -v sonar-scanner >/dev/null 2>&1; then
	echo "sonar-scanner not found in PATH. Install locally or run from CI image."
	exit 0
fi

PROJECT_KEY=${PROJECT_KEY:-"jenkins-pipeline-sample"}
SONAR_HOST_URL=${SONAR_HOST_URL:-"http://localhost:9000"}

sonar-scanner \
	-Dsonar.projectKey="${PROJECT_KEY}" \
	-Dsonar.sources=. \
	-Dsonar.host.url="${SONAR_HOST_URL}"

echo "SonarQube scan complete (check server for results)."
