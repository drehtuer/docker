FROM    debian:stable-slim

LABEL   name="teamspeak" \
        description="Teamspeak Server" \
        version="1.0" \
        maintainer="drehtuer@drehtuer.de"

ENV     TS_VERSION="3.0.13.8"
ENV     TS_DIR="teamspeak3-server_linux_amd64"
ENV     TS_FILE="${TS_DIR}-${TS_VERSION}.tar.bz2"
ENV     TS_URL="http://dl.4players.de/ts/releases/${TS_VERSION}/${TS_FILE}"


RUN     apt-get update \
        && apt-get install -y \
            wget \
            tar \
            bzip2 \
        && rm -rf /var/lib/apt/lists/* \
        && wget -q -O ${TS_FILE} "${TS_URL}" \
        && tar -xjf ${TS_FILE} \
        && adduser --no-create-home --shell /usr/sbin/nologin --disabled-password --disabled-login --gecos "TeamSpeak,,," teamspeak \
        && chown -R teamspeak /${TS_DIR}

EXPOSE  9987/udp
EXPOSE  30033/tcp
EXPOSE  10011/tcp

VOLUME  /${TS_DIR}/ts3server.sqlitedb
VOLUME  /${TS_DIR}/ts3server.ini
VOLUME  /${TS_DIR}/files
VOLUME  /${TS_DIR}/logs

USER    teamspeak

ENTRYPOINT  ["/${TS_DIR}/ts3server_minimal_runscript.sh"]
