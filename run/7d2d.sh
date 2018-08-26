#!/bin/sh
docker run \
    --network host \
    -p 8081:8081/tcp \
    -p 26900:26900/tcp \
    -p 26901:8082/tcp \
    -p 26900:26900/udp \
    -p 26901:26901/udp \
    -p 26902:26902/udp \
    --restart no \
    -v /var/data/docker/config/7d2d/serverconfig.xml:/opt/sdtd/serverconfig.xml:rw \
    -v /var/data/docker/config/7d2d/admin.xml:/opt/sdtd/admin.xml:rw \
    -v /var/data/docker/config/7d2d/webpermissions.xml:/opt/stdt/webpermissions.xml:rw \
    -v /var/data/docker/persist/7d2d/Save:/opt/sdtd/Save:rw \
    -d \
    drehtuer/7d2d:latest
