FROM      ubuntu:20.10

LABEL     name="Builder: deadbeef" \
          description="Build container for deadbeef, a Linux audio player similar to foobar2k" \
          maintainer="drehtuer@drehtuer.de" \
          version="1.0"

ENV       CC=clang
ENV       CXX=clang++

ENV       BUILD_DIR=/home/build
ENV       OUT_DIR=${BUILD_DIR}/out
ENV       DEB_DISTRO=groovy

ENV       DEADBEEF_REPO=https://github.com/DeaDBeeF-Player/deadbeef
ENV       DEADBEEF_TAG=1.8.4
ENV       DEADBEEF_DIR=deadbeef

ENV       DEADBEEF_PLUGIN_FILEBROWSER_REPO=https://gitlab.com/zykure/deadbeef-fb.git
ENV       DEADBEEF_PLUGIN_FILEBROWSER_TAG=master
ENV       DEADBEEF_PLUGIN_FILEBROWSER_DIR=deadbeef-filebrowser

ENV       DEADBEEF_PLUGIN_QUICKSEARCH_REPO=https://github.com/cboxdoerfer/ddb_quick_search.git
ENV       DEADBEEF_PLUGIN_QUICKSEARCH_TAG=master
ENV       DEADBEEF_PLUGIN_QUICKSEARCH_DIR=deadbeef-quicksearch

ENV       DEADBEEF_PLUGIN_MUSICAL_SPECTRUM_REPO=https://github.com/cboxdoerfer/ddb_musical_spectrum
ENV       DEADBEEF_PLUGIN_MUSICAL_SPECTRUM_TAG=master
ENV       DEADBEEF_PLUGIN_MUSICAL_SPECTRUM_DIR=deadbeef-musical-spectrum

ENV       DEADBEEF_PLUGIN_WAVEFORM_SEEKBAR_REPO=https://github.com/cboxdoerfer/ddb_waveform_seekbar.git
ENV       DEADBEEF_PLUGIN_WAVEFORM_SEEKBAR_TAG=master
ENV       DEADBEEF_PLUGIN_WAVEFORM_SEEKBAR_DIR=deadbeef-waveform-seekbar


ARG       DEBIAN_FRONTEND=noninteractive

RUN       apt-get update \
          && apt-get upgrade \
            --yes \
            -qq \
          && apt-get install \
            --no-install-recommends \
            --yes \
            -qq \
              autoconf \
              autogen \
              automake \
              autopoint \
              bzip2 \
              ca-certificates \
              clang \
              cmake \
              fakeroot \
              git \
              intltool \
              libasound2-dev \
              libavdevice-dev \
              libblocksruntime-dev \
              libc6-dev \
              libcddb2-dev \
              libcdio-cdda-dev \
              libcurl4-openssl-dev \
              libdbus-1-dev \
              libdispatch-dev \
              libexpat-dev \
              libfaad-dev \
              libfftw3-dev \
              libflac-dev \
              libglib2.0-bin \
              libglib2.0-dev \
              libgtk-3-dev \
              libgtk2.0-dev \
              libimlib2-dev \
              libjansson-dev \
              libjpeg8-dev \
              libmad0-dev \
              libmpg123-dev \
              libopus-dev \
              libopusfile-dev \
              libpulse-dev \
              libsamplerate0-dev \
              libsndfile-dev \
              libsqlite3-dev \
              libtool \
              libvorbis-dev \
              libwavpack-dev \
              libzip-dev \
              make \
              perl \
              pkg-config \
              software-properties-common \
              wget \
              yasm \
              zip \
              zlib1g-dev \
          && rm -rf /var/lib/apt/lists/*

WORKDIR   ${BUILD_DIR}

COPY      entrypoint.sh ${BUILD_DIR}/entrypoint.sh
COPY      control ${BUILD_DIR}/control
COPY      postinst ${BUILD_DIR}/postinst
COPY      postrm ${BUILD_DIR}/postrm

VOLUME    ${OUT_DIR}

ENTRYPOINT ${BUILD_DIR}/entrypoint.sh
