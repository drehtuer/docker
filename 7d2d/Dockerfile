FROM    debian:stable-slim

LABEL   name="7d2d" \
        description="Dedicated 7 days to die server" \
        version="1.0" \
        maintainer="drehtuer@drehtuer.net"

ENV     STEAMCMD_PATH="/opt/steamcmd" \
        STEAMCMD_URL="https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" \
        STEAM_APP_ID="294420" \
        SDTD_PATH="/opt/sdtd" \
        SDTD_USER="sdtd" \
        SDTD_CONFIG="serverconfig.xml"

RUN     dpkg --add-architecture i386 \
        && apt-get update \
        && apt-get install -y \
            curl \
            lib32stdc++6 \
            lib32gcc1 \
            libglu1 \
            libxcursor1 \
            libxrandr2 \
        && rm -rf /var/lib/apt/lists/* \
        && echo "System update done, installing steamcmd ..." \
        && mkdir -p ${STEAMCMD_PATH} \
        && cd ${STEAMCMD_PATH} \
        && curl -sqL "${STEAMCMD_URL}" | tar zxf - \
        && ulimit -n 2048 \
        && echo "Installing 7DayToDie ..." \
        && mkdir -p ${SDTD_PATH} \
        && ./steamcmd.sh +login anonymous +force_install_dir ${SDTD_PATH} +app_update ${STEAM_APP_ID} validate +quit \
        && cd ${SDTD_PATH} \
        && adduser --no-create-home --shell /usr/sbin/nologin --disabled-password --disabled-login --gecos "sdtd,,," ${SDTD_USER} \
        && chown -R ${SDTD_USER} ${SDTD_PATH} \
        && echo "Done"

EXPOSE  26900/tcp \
        8082\tcp \
        26900/udp \
        26901/udp \
        26902/udp

#VOLUME  ${SDTD_PATH}/${SDTD_CONFIG}

USER    ${SDTD_USER}

WORKDIR ${SDTD_PATH}

ENTRYPOINT ["./7DaysToDieServer.x86_64", "-configfile=${SDTD_CONFIG}", "-logfile", "/dev/stdout", "-quit", "-batchmode", "-nographics", "-dedicated"]
