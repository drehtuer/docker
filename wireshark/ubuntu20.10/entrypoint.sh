#!/bin/sh

git clone \
  --depth 1 \
  --branch ${WIRESHARK_TAG} \
  ${WIRESHARK_REPO} \
  ${WIRESHARK_DIR}

cd ${WIRESHARK_DIR}

dpkg-buildpackage \
  -b \
  -us \
  -uc \
  -jauto

mv ../*.deb ../out/
