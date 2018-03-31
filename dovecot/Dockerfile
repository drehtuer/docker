FROM    debian:stable-slim

LABEL   name="dovecot" \
        descript="IMAP mailserver" \
        version="1.0" \
        maintainer="drehtuer@drehtuer.net"

RUN     apt-get update \
        && apt-get install -y \
            dovecot-core \
            dovecot-imapd \
            dovecot-mysql \
            dovecot-antispam \
            dovecot-sieve \
            dovecot-managesieved \
            dovecot-lmtpd \
            dovecot-solr \
        && rm -Rf /var/lib/apt/list/*

EXPOSE  993/tcp

VOLUME  /etc/dovecot

ENTRYPOINT  ["top"]
