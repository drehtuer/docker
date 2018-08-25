FROM    debian:stable-slim

LABEL   name="7d2d" \
        description="Dedicated 7 days to die server" \
        version="1.0" \
        maintainer="drehtuer@drehtuer.net"

ENV     STEAMCMD_PATH="/opt/steamcmd"
        STEAMCMD_URL="https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz"
        STEAM_APP_ID="294420"
        7D2D_PATH="/opt/7d2d"
        7D2D_CONFIG="server_data/serverconfig.xml"

RUN     apt-get update \
        && apt-get install -y \
            curl \
            lib32gcc1 \
        && rm -rf /var/lib/apt/lists/* \
        && adduser --no-create-home --shell /usr/sbin/nologin --disabled-password --disabled-login --gecos "7d2d,,," 7d2d \
        && mkdir -p ${STEAMCMD_PATH} \
        && mkdir -p ${7D2D_PATH} \
        && cd ${STEAMCMD_PATH} \
        && curl -sqL ${STEAMCMD_URL} | tar zxf - \
        && ./steamcmd +login anonymous +force_install_dir ${7D2D_PATH} +app_update ${STEAM_APP_ID} +quit \
        && cd ${7D2D_PATH} \
        && ./update_check.sh \
        && chown -R 7d2d ${7D2D_PATH}

EXPOSE  26900/tcp \
        8082\tcp \
        26900/udp \
        26901/udp \
        26902/udp

VOLUME  ${7D2D_PATH}/${7D2D_CONFIG}

USER    7d2d

WORKDIR ${7D2D_PATH}

ENTRYPOINT ["./7DaysToDieServer.x86_64", "-configfile=${7D2D_CONFIG}", "-logfile", "/dev/stdout", "-quit", "-batchmode", "-nographics", "-dedicated"]
