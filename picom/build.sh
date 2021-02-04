#!/bin/sh

docker build \
  --tag picom:latest \
  --rm \
  $(dirname ${0})
