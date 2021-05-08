#!/bin/bash

set -euo pipefail
set -x

DEFAULT=(
    ./bin/server
)

systemd-socket-activate --listen "$(pwd)/service.sock" "${@:-${DEFAULT[@]}}"