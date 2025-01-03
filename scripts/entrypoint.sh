#!/usr/bin/env bash
#
# scripts/entrypoint.sh

echo "Container is starting with user: $(whoami)"

# Execute any command passed to the container
exec "$@"
