#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

MODE="${1:-}"

if [[ -z "$MODE" ]]; then
  echo "usage: $0 <size|performance>" >&2
  exit 1
fi

rm -rf build-em
bash ./build_osmesa_emcc.sh "$MODE"
JOBS="$(nproc)"
ninja -C build-em -j"$JOBS"
