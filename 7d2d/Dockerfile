FROM    debian:stable-slim

LABEL   name="7d2d" \
        description="Dedicated 7 days to die server" \
        version="1.0" \
        maintainer="drehtuer@drehtuer.net"

ENV     SDTD_BOOTSTRAP_URL="http://illy.bz/fi/7dtd/bootstrap.sh" \
        SDTD_BOOTSTRAP_BIN="/usr/bin/7dtd_bootstrap.sh" \
        SDTD_LOG="/var/log/7dtd.log" \
        SDTD_USR="sdtd" \
        SDTD_GRP="sdtd"

# Fixes apt-get warnings
ARG     DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN     dpkg --add-architecture i386 \
        && apt-get update \
	    && apt-get install -y \
            procps \
            gcc \
            netcat-openbsd \
            make \
            curl \
            wget \
            rsync \
            lib32stdc++6 \
            lib32gcc1 \
            libglu1 \
            libxcursor1 \
            libxrandr2 \
            telnet \
            xmlstarlet \
        && rm -rf /var/lib/apt/lists/* \
        && curl "${SDTD_BOOTSTRAP_URL}" -o ${SDTD_BOOTSTRAP_BIN} \
        && chmod +x ${SDTD_BOOTSTRAP_BIN} \
        && touch ${SDTD_LOG} \
        && chmod 666 ${SDTD_LOG} \
        && addgroup --gid 999 ${SDTD_GRP} \
        && adduser --disabled-login --disabled-password --gecos "sdtd,,," --uid 999 --gid 999 ${SDTD_USR}

EXPOSE  8082/tcp \
        26900/tcp \
        26900/udp \
        26901/udp \
        26902/udp \
        26903/udp

ENTRYPOINT  tail -f ${SDTD_LOG}
