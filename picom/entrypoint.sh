#!/bin/sh

git clone \
  --depth 1 \
  --branch ${PICOM_TAG} \
  ${PICOM_REPO} \
  ${PICOM_DIR}


cd ${PICOM_DIR}


git submodule \
  update \
    --init \
    --recursive

meson \
  --buildtype=release \
  -Dprefix=/usr \
  -Dwith_docs=true \
  . \
  build

ninja -C \
  build


DEB_DIR=${BUILD_DIR}/deb


mkdir -p \
  ${DEB_DIR}/usr/bin
mkdir -p \
  ${DEB_DIR}/usr/share/man/man1


echo "2.0" \
  >${DEB_DIR}/debian-binary


gzip -v \
  build/man/picom.1
gzip -v \
  build/man/picom-trans.1

install -sv \
  build/src/picom \
  ${DEB_DIR}/usr/bin/
install -v \
  bin/picom-trans \
  ${DEB_DIR}/usr/bin/
install -v \
  build/man/picom.1.gz \
  ${DEB_DIR}/usr/share/man/man1/
install -v \
  build/man/picom-trans.1.gz \
  ${DEB_DIR}/usr/share/man/man1/

install -v \
  ${BUILD_DIR}/control \
  ${DEB_DIR}/
install -v \
  ${BUILD_DIR}/postinst \
  ${DEB_DIR}/
install -v \
  ${BUILD_DIR}/postrm \
  ${DEB_DIR}/


DEB_BUILD=$(date +"%Y%m%d-%H%M")
DEB_ARCH=amd64


echo "Version: ${DEB_VERSION}-${DEB_BUILD}" \
  >>${DEB_DIR}/control
echo "Installed-Size: ${DEB_SIZE}" \
  >>${DEB_DIR}/control
echo "Architecture: ${DEB_ARCH}" \
  >>${DEB_DIR}/control


DEB_SIZE=$(du -s \
    ${DEB_DIR} \
  | awk \
    '{print int($1/1024)}' \
)


cd ${DEB_DIR}

find ./usr -type f \
  | while read i; do
    md5sum "${i}" \
      | sed 's/\.\///g' \
      >>${DEB_DIR}/md5sums
done

chmod -v \
  0644 \
    control \
    md5sums

chmod -v \
  0755 \
    postrm \
    postinst


fakeroot \
  -- \
    tar \
      zcvf \
        ./control.tar.gz \
        ./control \
        ./md5sums \
        ./postrm \
        ./postinst
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
      ${OUT_DIR}/picom-${DEB_VERSION}-${DEB_BUILD}_${DEB_ARCH}_${DEB_DISTRO}.deb \
      debian-binary \
      control.tar.gz \
      data.tar.gz

