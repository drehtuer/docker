#!/bin/sh

IMAGE_TAG="crelay:latest"
BUILD_DIR=/home/build

docker run \
  --rm \
  -it \
  --volume $(pwd)/out:${BUILD_DIR}/out \
  ${IMAGE_TAG}
