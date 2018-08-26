#!/bin/sh
docker run \
    -p 26900:26900/tcp \
    -p 26901:8082/tcp \
    -p 26900:26900/udp \
    -p 26901:26901/udp \
    -p 26902:26902/udp \
    --restart no \
    -d \
    drehtuer/7d2d:latest
