#!/bin/sh

docker build \
  --tag neovim:latest \
  --rm \
  $(dirname ${0})
