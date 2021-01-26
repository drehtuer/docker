#!/bin/sh

IMAGE_TAG=wireshark:latest

docker build \
  --tag ${IMAGE_TAG} \
  --rm \
  $(dirname ${0})
