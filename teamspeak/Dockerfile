FROM    debian:stable

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
            bzip2 \
            locales \
            tar \
            wget \
        && rm -rf /var/lib/apt/lists/* \
        && wget -q -O /${TS_FILE} "${TS_URL}" \
        && tar -xjf /${TS_FILE} \
        && rm ${TS_FILE} \
        && adduser --no-create-home --shell /usr/sbin/nologin --disabled-password --disabled-login --gecos "TeamSpeak,,," teamspeak \
        && chown -R teamspeak /${TS_DIR} \
        && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

ENV     LANG="en_US.utf-8"
ENV     LANGUAGE="en_US:en"
ENV     LC_ALL="en_US.UTF-8"

EXPOSE  9987/udp \
        30033/tcp \
        10011/tcp

VOLUME  /${TS_DIR}/ts3server.sqlitedb \
        /${TS_DIR}/ts3server.ini \
        /${TS_DIR}/files \
        /${TS_DIR}/logs

USER    teamspeak

ENTRYPOINT  ["sh", "/teamspeak3-server_linux_amd64/ts3server_minimal_runscript.sh"]
