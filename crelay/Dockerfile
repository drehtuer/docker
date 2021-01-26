FROM      ubuntu:16.04

LABEL     name="Builder: crelay" \
          description="Build container for crelay, a tool to control various USB relays" \
          maintainer="drehtuer@drehtuer.de" \
          version="1.0"

ENV       BUILD_DIR=/home/build
ENV       OUT_DIR=${BUILD_DIR}/out

ENV       CRELAY_REPO=https://github.com/ondrej1024/crelay
ENV       CRELAY_TAG=V0.14
ENV       CRELAY_DIR=crelay
ENV       CRELAY_PREFIX=
# enable: y
ENV       CRELAY_CONRAD=y
ENV       CRELAY_SAINSMART=y
ENV       CRELAY_SAINSMART16=y
ENV       CRELAY_HIDAPI=y

ENV       DEB_VERSION=0.14
ENV       DEB_ARCH=amd64
ENV       DEB_DISTRO=xenial

ARG       DEBIAN_FRONTEND=noninteractive

RUN       apt-get update \
          && apt-get upgrade \
            --yes \
            -qq \
          && apt-get install \
            --no-install-recommends \
            --yes \
            -qq \
              build-essential \
              ca-certificates \
              git \
              fakeroot \
              libftdi-dev \
              libhidapi-dev \
              libusb-1.0-0-dev \
          && rm -rf /var/lib/apt/lists/*

WORKDIR   ${BUILD_DIR}

COPY      entrypoint.sh ${BUILD_DIR}/entrypoint.sh
COPY      control ${BUILD_DIR}/control
COPY      postinst ${BUILD_DIR}/postinst
COPY      postrm ${BUILD_DIR}/postrm

VOLUME    ${OUT_DIR}

ENTRYPOINT ${BUILD_DIR}/entrypoint.sh
