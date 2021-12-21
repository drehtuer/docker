#!/bin/sh

docker build \
  --tag emacs:latest \
  --rm \
  $(dirname ${0})
