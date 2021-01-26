#!/bin/bash

rm -rfv \
  ${OUT_DIR}/*

# application
git clone \
  --depth 1 \
  --branch ${CRELAY_TAG} \
  ${CRELAY_REPO} \
  ${BUILD_DIR}/${CRELAY_DIR}

cd ${BUILD_DIR}/${CRELAY_DIR}/src

make \
  DRV_CONRAD=${CRELAY_CONRAD} \
  DRV_SAINSMART=${CRELAY_SAINSMART} \
  DRV_SAINSMART16=${CRELAY_SAINSMART16} \
  DRV_HIDAPI=${CRELAY_HIDAPI} \
  PREFIX=${CRELAY_PREFIX} \
  -j

# Build package
DEB_DIR=${BUILD_DIR}/deb
DEB_BUILD=$(date +"%Y%m%d-%H%M")

# Collect files
install -v \
  -m 0755 \
  -s \
  ${BUILD_DIR}/${CRELAY_DIR}/src/crelay \
  -D \
  ${DEB_DIR}/usr/bin/crelay

# Build debian package
echo "2.0" \
  >${DEB_DIR}/debian-binary

DEB_SIZE="$(du -s \
    ${DEB_DIR} \
    | cut -f1 \
) K"

install -v \
  -m 0644 \
  ${BUILD_DIR}/control \
  ${DEB_DIR}/

echo "Version: ${DEB_VERSION}-${DEB_BUILD}" \
  >>${DEB_DIR}/control
echo "Installed-Size: ${DEB_SIZE}" \
  >>${DEB_DIR}/control
echo "Architecture: ${DEB_ARCH}" \
  >>${DEB_DIR}/control

install -v \
  -m 0755 \
  ${BUILD_DIR}/postinst \
  ${DEB_DIR}/

install -v \
  -m 0755 \
  ${BUILD_DIR}/postrm \
  ${DEB_DIR}/

cd ${DEB_DIR}

find ./usr -type f \
  | while read i; do
    md5sum "${i}" \
      | sed 's/\.\///g' \
      >>${DEB_DIR}/md5sums
done

# no shared libs are build
touch shlibs

chmod -v \
  0644 \
    md5sums \
    shlibs

fakeroot \
  -- \
    tar \
      zcvf \
      ./control.tar.gz \
      ./control \
      ./md5sums \
      ./postrm \
      ./postinst \
      ./shlibs

fakeroot \
  -- \
    tar \
      zcvf \
      ./data.tar.gz \
      ./usr

fakeroot \
  -- \
    ar \
      cr \
      ${OUT_DIR}/crelay-${DEB_VERSION}-${DEB_BUILD}_${DEB_ARCH}_${DEB_DISTRO}.deb \
      debian-binary \
      control.tar.gz \
      data.tar.gz

