#!/bin/bash

set -euxo pipefail

CID=$(docker create $(DOCKER_BUILDKIT=1 docker build -q .))
trap "{ docker rm '$CID'; }" EXIT 

mkdir -p rootfs
docker export "$CID" | tar -C rootfs -xf -

# TODO: terminal, entrypoint, user... ?

rm config.json
runc spec --rootless
mv config.json{,.generated}

(docker inspect "$CID" ; cat config.json.generated) \
    | jq > config.json -s -f /dev/fd/3 3<<'EOF'
(first|first) as $dockerinfo
| last
| .process.terminal = false 
# | .process.user = (
#     $dockerinfo.Config.User 
#     | split(":") as [$uid, $gid] 
#     | {uid: $uid|tonumber, gid: $gid|tonumber}
#     )
| .process.args = ($dockerinfo.Config.Entrypoint)
EOF
