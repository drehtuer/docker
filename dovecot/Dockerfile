FROM    	debian:stable-slim

LABEL   	name="dovecot" \
        	descript="IMAP mailserver with SOLR, Spamassassin retrain" \
        	version="1.0" \
        	maintainer="drehtuer@drehtuer.net"

ARG			DEBIAN_FRONTEND=noninteractive

RUN     	apt-get update \
        	&& apt-get install -y \
        	    dovecot-core \
        	    dovecot-imapd \
        	    dovecot-sieve \
        	    dovecot-lmtpd \
        	    dovecot-solr \
				spamdc \
        	&& rm -Rf /var/lib/apt/list/*

EXPOSE  	993/tcp

ADD 		start.sh /

ENTRYPOINT	/start.sh
