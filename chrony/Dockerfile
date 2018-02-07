FROM    debian:stable-slim

LABEL   name="chrony" \
        description="Chrony NTP server" \
        version="1.0" \
        maintainer="drehtuer@drehtuer.net"

RUN     apt-get update \
        && apt-get install -y \
            chrony \
        && rm -rf /var/lib/apt/lists/*

VOLUME  /etc/chrony \
        /var/lib/chrony

ENTRYPOINT  ["chronyd", "-f", "/etc/chrony/chrony.conf", "-d", "-u", "_chrony"]
