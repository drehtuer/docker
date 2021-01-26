FROM    ubuntu:20.10

LABEL   name="Wireshark" \
        description="Network package sniffer" \
        version="1.0" \
        maintainer="drehtuer@drehtuer.de"

ARG     DEBIAN_FRONTEND=noninteractive

ENV     BUILD_DIR=/home/build
ENV     WIRESHARK_REPO=https://github.com/wireshark/wireshark.git
ENV     WIRESHARK_TAG=wireshark-3.4.0
ENV     WIRESHARK_DIR=wireshark

VOLUME  ${BUILD_DIR}

RUN     apt-get update \
        && apt-get upgrade \
          -y \
        && apt-get install \
          --no-install-recommends \
          -y \
            asciidoctor \
            bison \
            build-essential \
            ca-certificates \
            cmake \
            debhelper \
            dh-python \
            docbook-xml \
            docbook-xsl \
            doxygen \
            dpkg-dev \
            fakeroot \
            flex \
            gettext \
            git \
            gnupg \
            gnutls-dev \
            libbrotli-dev \
            libc-ares-dev \
            libc-dev \
            libcap-dev \
            libgcrypt-dev \
            libglib2.0-dev \
            libkrb5-dev \
            liblua5.2-dev \
            liblz4-dev \
            libmaxminddb-dev \
            libminizip-dev \
            libnghttp2-dev \
            libnl-3-dev \
            libnl-cli-3-dev \
            libnl-genl-3-dev \
            libnl-route-3-dev \
            libopus-dev \
            libparse-yapp-perl \
            libpcap-dev \
            libsbc-dev \
            libsmi-dev \
            libsnappy-dev \
            libspandsp-dev \
            libspeexdsp-dev \
            libssh-gcrypt-dev \
            libsystemd-dev \
            libtool-bin \
            libxml2-dev \
            libxml2-utils \
            libzstd-dev \
            lsb-release \
            perl \
            pkgconf \
            po-debconf \
            python3 \
            python3-ply \
            qtbase5-dev \
            qtmultimedia5-dev \
            qttools5-dev \
            quilt \
            xsltproc \
            zlib1g-dev \
        && rm -rf /var/lib/apt/lists/*

WORKDIR ${BUILD_DIR}

COPY    entrypoint.sh ${BUILD_DIR}/entrypoint.sh

ENTRYPOINT  ${BUILD_DIR}/entrypoint.sh
