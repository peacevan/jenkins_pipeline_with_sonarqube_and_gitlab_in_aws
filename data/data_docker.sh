#!/usr/bin/env bash
set -euo pipefail

# Standardized helper for building Docker images used by the pipeline
echo "[data/data_docker.sh] Building Docker images (placeholder)"

command -v docker >/dev/null 2>&1 || { echo "docker not found in PATH"; exit 1; }

IMAGE_NAME=${IMAGE_NAME:-"my-service:latest"}
DOCKERFILE=${DOCKERFILE:-"./Dockerfile"}

echo "Building image ${IMAGE_NAME} from ${DOCKERFILE}"
docker build -t "${IMAGE_NAME}" -f "${DOCKERFILE}" .

echo "Done. Push images to registry separately (CI credentials required)."
