#!/bin/sh

IMAGE_TAG="deadbeef:latest"

docker build \
  --rm \
  --progress plain \
  --tag ${IMAGE_TAG} \
  .
