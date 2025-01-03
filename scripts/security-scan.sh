#!/usr/bin/env bash
#
# scripts/security-scan.sh
#
# Usage: ./scripts/security-scan.sh [IMAGE_NAME]

IMAGE_NAME=${1:-ubuntu-hardened:latest}

echo "Running Trivy scan on image: $IMAGE_NAME ..."
trivy image --exit-code 1 --severity CRITICAL,HIGH $IMAGE_NAME
