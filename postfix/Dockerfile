FROM    debian:stable-slim

LABEL   name="postfix" \
        descript="Postfix SMTP server with SPF, greylisting" \
        version="1.0" \
        maintainer="drehtuer@drehtuer.net"

RUN     apt-get update \
        && apt-get install -y \
            postfix \
            postfix-policyd-spf-python \
            postfix-mysql \
        && rm -Rf /var/lib/apt/list/*

EXPOSE  25/tcp \
        587/tcp

VOLUME  /etc/postfix

ENTRYPOINT  ["top"]
