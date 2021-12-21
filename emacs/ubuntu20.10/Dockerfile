FROM    ubuntu:20.10

LABEL   name="Emacs" \
        description="Emacs editor" \
        version="1.0" \
        maintainer="drehtuer@drehtuer.de"

ARG     DEBIAN_FRONTEND=noninteractive

ENV     BUILD_DIR=/home/build

VOLUME  ${BUILD_DIR}

RUN     echo "Europe/Berlin" > /etc/timezone \
        && dpkg-reconfigure -f noninteractive tzdata \
        && apt-get update \
        && apt-get upgrade \
          -y \
        && apt-get install \
          --no-install-recommends \
          -y \
            build-essential \
            ca-certificates \
            wget \
            xorg-dev \
            libgtk-3-dev \
            libwebkit2gtk-4.0-dev \
            gnutls-dev \
            libgif-dev \
            libx11-xcb-dev \
            libotf-dev \
            libjansson-dev \
            libsystemd-dev \
            libgpm-dev \
            libtinfo-dev \
            libncurses-dev \
            libm17n-dev \
        && rm -rf /var/lib/apt/lists/*

WORKDIR ${BUILD_DIR}

COPY    entrypoint.sh ${BUILD_DIR}/entrypoint.sh

ENTRYPOINT  ${BUILD_DIR}/entrypoint.sh
