#!/bin/bash

set -euo pipefail
set -x

systemd-socket-activate --listen "`pwd`/service.sock" ./bin/server