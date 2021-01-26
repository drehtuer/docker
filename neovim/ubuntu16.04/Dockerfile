FROM    ubuntu:xenial

LABEL   name="Neovim" \
        description="Neovim text editor" \
        version="1.0" \
        maintainer="drehtuer@drehtuer.de"

ARG     DEBIAN_FRONTEND=noninteractive

ENV     BUILD_DIR=/home/build
ENV     NEOVIM_REPO=https://github.com/neovim/neovim.git
ENV     NEOVIM_TAG=v0.4.4
ENV     NEOVIM_DIR=neovim

VOLUME  ${BUILD_DIR}

RUN     apt-get update \
        && apt-get upgrade \
          -y \
        && apt-get install \
          --no-install-recommends \
          -y \
            build-essential \
            ca-certificates \
            cmake \
            git \
            gperf \
            libluajit-5.1-dev \
            libmsgpack-dev \
            libtermkey-dev \
            libunibilium-dev \
            libutf8proc-dev \
            libuv1-dev \
            luajit \
            luarocks \
            pkgconf \
            libtool-bin \
            ninja-build \
            autoconf \
            automake \
            unzip \
            gettext \
        && rm -rf /var/lib/apt/lists/*

WORKDIR ${BUILD_DIR}

COPY    entrypoint.sh ${BUILD_DIR}/entrypoint.sh

ENTRYPOINT  ${BUILD_DIR}/entrypoint.sh
