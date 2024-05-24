#!/bin/bash -x

IMAGE=docker.io/densukest/skrsql:v4

logger -t skr-setup "check image"
test $(podman image ls -q "${IMAGE}" | wc -l) -gt 0
if [ $? != 0 ]; then
  logger -t skr-setup "import"
  podman system migrate
  podman image pull "${IMAGE}"
fi
