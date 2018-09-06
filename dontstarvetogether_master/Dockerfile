FROM    debian:stable-slim

LABEL   name="dontstarvetogether_main" \
        description="Dedicated Don't starve together server main" \
        version="1.0" \
        maintainer="drehtuer@drehtuer.net"

ENV     STEAMCMD_URL="https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" \
        STEAMCMD_DIR="/home/steam" \
        DST_DIR="/home/dst" \
        DST_USR="dst" \
        DST_GRP="dst" \
        DST_STORAGE="/home/storage" \
        DST_CLUSTER="drehtuer.net" \
        DST_SHARD="Master"

# Fixes apt-get warnings
ARG     DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN     dpkg --add-architecture i386 \
        && apt-get update \
	    && apt-get install -y \
            curl \
            lib32stdc++6 \
            lib32gcc1 \
            libcurl4-gnutls-dev:i386 \
            cron \
        && rm -rf /var/lib/apt/lists/* \
        && addgroup --gid 999 ${DST_GRP} \
        && adduser --disabled-login --disabled-password --gecos "dst,,," --uid 999 --gid 999 ${DST_USR} \
        && mkdir -p ${STEAMCMD_DIR} \
        && cd ${STEAMCMD_DIR} \
        && curl -sqL ${STEAMCMD_URL} | tar zxf - \
        && chown -R ${DST_USR}:${DST_GRP} ${STEAMCMD_DIR} \
        && echo "0 6 * * * ${DST_USR} ${DST_DIR}/startDST.sh update" > /etc/cron.d/dst

EXPOSE  10999/udp

WORKDIR ${DST_DIR}

COPY    startDST.sh ${DST_DIR}

USER    ${DST_USR}

ENTRYPOINT  [ "./startDST.sh" ]
