FROM    debian:stable-slim

LABEL   name="chrony" \
        description="Chrony NTP server" \
        version="1.0" \
        maintainer="drehtuer@drehtuer.net"

RUN     apt-get update \
        && apt-get install -y \
            chrony \
        && rm -rf /var/lib/apt/lists/* \
        && adduser --no-create-home --shell /usr/bin/nologin --disable-password --disable-login --gecos "chrony,,," chrony

VOLUME  /etc/chrony \
        /var/lib/chrony

ENTRYPOINT  ["chronyd", "-f", "/etc/chrony/chrony.conf", "-d", "-u", "chrony"]
