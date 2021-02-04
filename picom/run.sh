#!/bin/sh

BUILD_DIR=/home/build
BIND_DIR=$(readlink -f $(dirname ${0}))
IMAGE=picom

docker run \
  --rm \
  -it \
  -v ${BIND_DIR}/out:${BUILD_DIR}/out:rw \
  ${IMAGE}
