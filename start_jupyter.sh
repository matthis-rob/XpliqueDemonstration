#!/usr/bin/env bash
set -euo pipefail

project_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export JUPYTER_PATH="$project_dir/.venv/share/jupyter${JUPYTER_PATH:+:$JUPYTER_PATH}"

cd "$project_dir"
exec "$project_dir/.venv/bin/jupyter" lab "$@"
