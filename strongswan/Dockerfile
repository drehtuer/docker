FROM        debian:stable-slim

LABEL       name="StrongSwan" \
            description="StrongSwan VPN" \
            version="1.0" \
            maintainer="drehtuer@drehtuer.net"

RUN         apt-get update \
            && apt-get install -y \
                iptables \
                strongswan-charon \
                strongswan-starter \
                libstrongswan-standard-plugins \
            && rm -rf /var/lib/apt/lists/*

EXPOSE      4500/udp \
            500/udp

VOLUME      /etc/ipsec.conf \
            /etc/ipsec.secrets \
            /etc/strongswan.conf \
            /etc/ipsec.d/firewall.updown

ENTRYPOINT  ["/usr/sbin/ipsec"]
CMD ["start", "--nofork"]
