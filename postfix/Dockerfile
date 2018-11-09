FROM    	debian:stable-slim

LABEL   	name="postfix" \
        	descript="Postfix SMTP server with TLS, DKIM, SPF, DMARC, greylisting" \
        	version="1.0" \
        	maintainer="drehtuer@drehtuer.net"

ARG 		DEBIAN_FRONTEND=noninteractive

RUN     	apt-get update \
        	&& apt-get install -y \
        	    postfix \
        	    postfix-mysql \
        	    postfix-policyd-spf-python \
				postgrey \
				opendkim \
				opendkim-tools \
				opendmarc \
        	&& rm -Rf /var/lib/apt/list/*

EXPOSE  	25/tcp \
        	587/tcp

ADD 		start.sh /

ENTRYPOINT  /start.sh
