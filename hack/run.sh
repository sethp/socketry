#!/bin/bash

set -euo pipefail
set -x

DEFAULT=(
    ./bin/server
)

systemd-socket-activate \
    -E XDG_RUNTIME_DIR \
    --listen "$(pwd)/service.sock" \
    "${@:-${DEFAULT[@]}}"