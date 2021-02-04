FROM    ubuntu:20.10

LABEL   name="picom" \
        description="picom composite manager" \
        version="1.0" \
        maintainer="drehtuer@drehtuer.de"

ARG     DEBIAN_FRONTEND=noninteractive

ENV     BUILD_DIR=/home/build
ENV     OUT_DIR=${BUILD_DIR}/out

ENV     PICOM_REPO=https://github.com/yshui/picom
ENV     PICOM_TAG=v8.2
ENV     PICOM_DIR=picom

ENV     DEB_VERSION=8.2
ENV     DEB_ARCH=amd64
ENV     DEB_DISTRO=groovy

RUN     apt-get update \
        && apt-get upgrade \
          -y \
        && apt-get install \
          --no-install-recommends \
          -y \
            asciidoc \
            build-essential \
            ca-certificates \
            docbook-xml \
            fakeroot \
            git \
            libconfig-dev \
            libdbus-1-dev \
            libev-dev \
            libevdev-dev \
            libgl-dev \
            libpcre2-dev \
            libpcre3-dev \
            libpixman-1-dev \
            libx11-dev \
            libx11-xcb-dev \
            libxcb-composite0-dev \
            libxcb-damage0-dev \
            libxcb-glx0-dev \
            libxcb-image0-dev \
            libxcb-present-dev \
            libxcb-render-util0-dev \
            libxcb-render0-dev \
            libxcb-shape0-dev \
            libxcb-xfixes0-dev \
            libxcb-xinerama0-dev \
            libxcb1-dev \
            libxext-dev \
            libxext-dev \
            meson \
            ninja-build \
            uthash-dev \
        && rm -rf /var/lib/apt/lists/*

WORKDIR ${BUILD_DIR}

COPY    entrypoint.sh ${BUILD_DIR}/entrypoint.sh
COPY    control ${BUILD_DIR}/control
COPY    postinst ${BUILD_DIR}/postinst
COPY    postrm ${BUILD_DIR}/postrm

VOLUME  ${OUT_DIR}

ENTRYPOINT  ${BUILD_DIR}/entrypoint.sh
