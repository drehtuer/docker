FROM		debian:stable-slim

LABEL		name="ClamAV" \
			description="Anti Virus Scanner" \
			version="1.0" \
			maintauner="drehtuer@drehtuer.net"

ARG 		DEBIAN_FRONTEND=noninteractive

RUN 		apt-get update \
			&& apt-get install -y \
				clamav-daemon \
			&& rm -Rf /var/lib/apt/list/*

VOLUME 		/etc/clamav \
			/var/lib/clamav \
	 		/var/run/clamav

ADD 		start.sh /

ENTRYPOINT 	[ "/start.sh" ]
