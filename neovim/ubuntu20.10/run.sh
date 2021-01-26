#!/bin/sh

BUILD_DIR=/home/build
BIND_DIR=$(readlink -f $(dirname ${0}))
IMAGE=neovim

docker run \
  --rm \
  -v ${BIND_DIR}/out:${BUILD_DIR}/out:rw \
  ${IMAGE}
