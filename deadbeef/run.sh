#!/bin/sh

IMAGE_TAG="deadbeef:latest"
BUILD_DIR=/home/build

docker run \
  --rm \
  -it \
  --volume $(pwd)/out:${BUILD_DIR}/out \
  ${IMAGE_TAG}
