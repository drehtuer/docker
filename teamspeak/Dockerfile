FROM    debian:stable-slim

LABEL   name="teamspeak" \
        description="Teamspeak Server" \
        version="1.0" \
        maintainer="drehtuer@drehtuer.de"

ENV     TS_VERSION="3.4.0"
ENV     TS_DIR="teamspeak3-server_linux_amd64"
ENV     TS_FILE="${TS_DIR}-${TS_VERSION}.tar.bz2"
ENV     TS_URL="http://dl.4players.de/ts/releases/${TS_VERSION}/${TS_FILE}"
ENV     TS_USER="teamspeak"
   
RUN     apt-get update \
        && DEBIAN_FRONTEND=noninteractive apt-get install -y \
            bzip2 \
            tar \
            wget \
            locales \
        && rm -rf /var/lib/apt/lists/* \
        && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
        && dpkg-reconfigure --frontend=noninteractive locales \
        && update-locale LANG=en_US.UTF-8 \
        && wget -q -O /${TS_FILE} "${TS_URL}" \
        && tar -xjf /${TS_FILE} \
        && rm ${TS_FILE} \
        && adduser --no-create-home --shell /usr/sbin/nologin --disabled-password --disabled-login --gecos "TeamSpeak,,," --uid 999 ${TS_USER} \
        && chown -R ${TS_USER} /${TS_DIR}

EXPOSE  9987/udp \
        30033/tcp \
        10011/tcp

VOLUME  /${TS_DIR}/ts3server.ini \
        /${TS_DIR}/files \
        /${TS_DIR}/logs

USER    teamspeak

ENV     LANG="en_US.UTF-8"
ENV     LD_LIBRARY_PATH="/${TS_DIR}:${LD_LIBRARY_PATH}"

WORKDIR /${TS_DIR}

ENTRYPOINT  ./ts3server inifile=ts3server.ini license_accepted=1
