#!/bin/sh
docker run \
    -p 26900:26900/tcp \
    -p 26903:8082/tcp \
    -p 26900:26900/udp \
    -p 26900:26900/udp \
    -p 26901:26901/udp \
    -p 26902:26902/udp \
    -v /var/data/docker/config/7d2d/serverconfig.xml:/opt/7d2d/server_data/serverconfig2.xml \
    --restart no \
    7d2d
