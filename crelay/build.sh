#!/bin/sh

IMAGE_TAG="crelay:latest"

docker build \
  --rm \
  --progress plain \
  --tag ${IMAGE_TAG} \
  .
