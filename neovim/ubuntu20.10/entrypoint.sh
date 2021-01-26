#!/bin/sh

CPACK_VERSION=$(echo ${NEOVIM_TAG} | sed -n 's/[[:alpha:]]*\([[:digit:]].*\)/\1/p')
CPACK_MAINTAINER="drehtuer@drehtuer.de"

git clone \
  --depth 1 \
  --branch ${NEOVIM_TAG} \
  ${NEOVIM_REPO} \
  ${NEOVIM_DIR}

cd ${NEOVIM_DIR}

make \
  CMAKE_BUILD_TYPE=Release

cd build
cpack \
  -G DEB \
  -D CPACK_PACKAGE_VERSION="${CPACK_VERSION}" \
  -D CPACK_DEBIAN_PACKAGE_MAINTAINER="${CPACK_MAINTAINER}"

mv *.deb ../../out/
