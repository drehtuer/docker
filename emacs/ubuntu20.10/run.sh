#!/bin/sh

BUILD_DIR=/home/build
BIND_DIR=$(readlink -f $(dirname ${0}))
IMAGE=emacs
EMACS_TAR_GZ=https://ftp.wayne.edu/gnu/emacs/emacs-27.2.tar.gz

docker run \
  --rm \
  -it \
  -e EMACS_TAR_GZ=${EMACS_TAR_GZ} \
  -v ${BIND_DIR}/out:${BUILD_DIR}/out:rw \
  ${IMAGE}
