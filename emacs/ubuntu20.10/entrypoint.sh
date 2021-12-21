#!/bin/sh

wget \
  --progress=bar \
  ${EMACS_TAR_GZ}
tar zxf \
  $(basename ${EMACS_TAR_GZ})

cd $(echo $(basename ${EMACS_TAR_GZ}) | sed -e 's/^\(.*\)\.tar\.gz$/\1/')

./configure \
  --prefix=/usr \
  --with-imagemagick \
  --with-x \
  --with-xwidgets
