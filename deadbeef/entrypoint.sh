#!/bin/bash

rm -rfv ${OUT_DIR}/*

# application
git clone \
  --depth 1 \
  --branch ${DEADBEEF_TAG} \
  ${DEADBEEF_REPO} \
  ${BUILD_DIR}/${DEADBEEF_DIR}

cd ${BUILD_DIR}/${DEADBEEF_DIR}

git submodule update \
  --init

./autogen.sh
./configure \
  --prefix /usr
make -j \
  >/dev/null
# For building plugins later
make install

# plugin: filebrowser
git clone \
  --depth 1 \
  --branch ${DEADBEEF_PLUGIN_FILEBROWSER_TAG} \
  ${DEADBEEF_PLUGIN_FILEBROWSER_REPO} \
  ${BUILD_DIR}/${DEADBEEF_PLUGIN_FILEBROWSER_DIR}

cd ${BUILD_DIR}/${DEADBEEF_PLUGIN_FILEBROWSER_DIR}

# patches
# https://github.com/DeaDBeeF-Player/deadbeef-plugin-builder/blob/master/plugins/ddb_filebrowser/deadbeef-fb.patch
sed -i \
  's/EXTRA_FLAGS = -Werror/EXTRA_FLAGS =/' \
    Makefile.am
sed -i \
  's/ddb_misc_filebrowser_GTK2_la_LDFLAGS = -module/ddb_misc_filebrowser_GTK2_la_LDFLAGS = -module -avoid-version/' \
    Makefile.am
sed -i \
  's/ddb_misc_filebrowser_GTK3_la_LDFLAGS = -module/ddb_misc_filebrowser_GTK3_la_LDFLAGS = -module -avoid-version/' \
    Makefile.am
sed -i \
  's/int errno/errno/g' \
    utils.c

./autogen.sh
./configure
make -j \
  >/dev/null


# plugin: quick search
git clone \
  --depth 1 \
  --branch ${DEADBEEF_PLUGIN_QUICKSEARCH_TAG} \
  ${DEADBEEF_PLUGIN_QUICKSEARCH_REPO} \
  ${BUILD_DIR}/${DEADBEEF_PLUGIN_QUICKSEARCH_DIR}

cd ${BUILD_DIR}/${DEADBEEF_PLUGIN_QUICKSEARCH_DIR}

make -j \
  >/dev/null


# plugin: musical spectrum
git clone \
  --depth 1 \
  --branch ${DEADBEEF_PLUGIN_MUSICAL_SPECTRUM_TAG} \
  ${DEADBEEF_PLUGIN_MUSICAL_SPECTRUM_REPO} \
  ${BUILD_DIR}/${DEADBEEF_PLUGIN_MUSICAL_SPECTRUM_DIR}

cd ${BUILD_DIR}/${DEADBEEF_PLUGIN_MUSICAL_SPECTRUM_DIR}

sed -i \
  's/$(CC) $(CFLAGS) $1 $2 $< -c -o $@/echo $(CC) $(CFLAGS) $1 $2 $< -c -o $@\n\t$(CC) $(CFLAGS) $1 $2 $< -c -o $@/' \
    Makefile
sed -i \
  's/$(CC) $(LDFLAGS) $1 $2 $3 -o $@/echo $(CC) $(LDFLAGS) $1 $2 $3 -o $@\n\t$(CC) $(CFLAGS) $(LDFLAGS) $1 $2 $3 -o $@/' \
    Makefile

make -j \
  >/dev/null


# plugin: waveform seekbar
git clone \
  --depth 1 \
  --branch ${DEADBEEF_PLUGIN_WAVEFORM_SEEKBAR_TAG} \
  ${DEADBEEF_PLUGIN_WAVEFORM_SEEKBAR_REPO} \
  ${BUILD_DIR}/${DEADBEEF_PLUGIN_WAVEFORM_SEEKBAR_DIR}

cd ${BUILD_DIR}/${DEADBEEF_PLUGIN_WAVEFORM_SEEKBAR_DIR}

sed -i \
  's/CFLAGS+=-Wall -O2 -g -fPIC -std=c99 -D_GNU_SOURCE/CFLAGS+=-Wall -O2 -fPIC -std=c99 -D_GNU_SOURCE -lm/' \
    Makefile
sed -i \
  's/LDFLAGS+=-shared/LDFLAGS+=-shared -lm/' \
    Makefile
sed -i \
  's/$(CC) $(LDFLAGS) $1 $2 $3 -o $@/$(CC) $(CFLAGS) $(LDFLAGS) $1 $2 $3 -o $@/' \
    Makefile

make -j \
  >/dev/null


# Collect files
DEB_DIR=${BUILD_DIR}/deb

# binary
mkdir -pv \
  ${DEB_DIR}/usr/bin
strip \
  --strip-unneeded \
    ${BUILD_DIR}/${DEADBEEF_DIR}/deadbeef
cp -v \
  ${BUILD_DIR}/${DEADBEEF_DIR}/deadbeef \
  ${DEB_DIR}/usr/bin/

# doc
mkdir -pv \
  ${DEB_DIR}/usr/share/doc/deadbeef

function cpyDoc {
  cp -v \
    ${BUILD_DIR}/${DEADBEEF_DIR}/${1} \
    ${DEB_DIR}/usr/share/doc/deadbeef/
}
cpyDoc COPYING.GPLv2
cpyDoc COPYING.LGPLv2.1
cpyDoc ChangeLog
cpyDoc README
cpyDoc about.txt
cpyDoc translation/help.ru.txt
cpyDoc help.txt
cpyDoc translators.txt

# libraries
mkdir -pv \
  ${DEB_DIR}/usr/lib/deadbeef
for i in $(find ${BUILD_DIR} -name "*.so" -type f); do
  strip \
    --strip-unneeded \
    ${i}
  cp -v \
    ${i} \
    ${DEB_DIR}/usr/lib/deadbeef/
done

# icons
function cpyIcon {
  mkdir -pv \
    ${DEB_DIR}/usr/share/icons/hicolor/${1}/apps
  cp -v \
    ${BUILD_DIR}/${DEADBEEF_DIR}/icons/${1}/${2} \
    ${DEB_DIR}/usr/share/icons/hicolor/${1}/apps/
}

cpyIcon scalable deadbeef.svg
cpyIcon 256x256  deadbeef.png
cpyIcon 32x32    deadbeef.png
cpyIcon 16x16    deadbeef.png
cpyIcon 96x96    deadbeef.png
cpyIcon 192x192  deadbeef.png
cpyIcon 72x72    deadbeef.png
cpyIcon 36x36    deadbeef.png
cpyIcon 128x128  deadbeef.png
cpyIcon 24x24    deadbeef.png
cpyIcon 48x48    deadbeef.png
cpyIcon 22x22    deadbeef.png
cpyIcon 64x64    deadbeef.png

# pixmap
function cpyPixmap {
  mkdir -pv \
    ${DEB_DIR}/usr/share/deadbeef/pixmaps
  cp -v \
    ${BUILD_DIR}/${DEADBEEF_DIR}/pixmaps/${1} \
    ${DEB_DIR}/usr/share/deadbeef/pixmaps/
}

cpyPixmap buffering_16.png
cpyPixmap noartwork.png
cpyPixmap pause_16.png
cpyPixmap play_16.png

# desktop file
mkdir -pv \
  ${DEB_DIR}/usr/share/applications/
cp -v \
  ${BUILD_DIR}/${DEADBEEF_DIR}/deadbeef.desktop \
  ${DEB_DIR}/usr/share/applications/


# Build debian package
echo "2.0" \
  >${DEB_DIR}/debian-binary

DEB_BUILD=$(date +"%Y%m%d-%H%M")
DEB_VERSION=${DEADBEEF_TAG}
DEB_ARCH=amd64
DEB_SIZE=$(du -s \
    ${DEB_DIR} \
  | awk \
    '{print int($1/1024)}' \
)

cp -v \
  ${BUILD_DIR}/control \
  ${DEB_DIR}/
echo "Version: ${DEB_VERSION}-${DEB_BUILD}" \
  >>${DEB_DIR}/control
echo "Installed-Size: ${DEB_SIZE}" \
  >>${DEB_DIR}/control
echo "Architecture: ${DEB_ARCH}" \
  >>${DEB_DIR}/control

cp -v \
  ${BUILD_DIR}/postinst \
  ${DEB_DIR}/

cp -v \
  ${BUILD_DIR}/postrm \
  ${DEB_DIR}/

cd ${DEB_DIR}

find ./usr -type f \
  | while read i; do
    md5sum "${i}" \
      | sed 's/\.\///g' \
      >>${DEB_DIR}/md5sums
done

ls ${DEB_DIR}/usr/lib/deadbeef/*.so \
  | while read i; do
    echo "$(basename ${i} .so) 0 deadbeef" \
    >>${DEB_DIR}/shlibs
done

chmod -v \
  0644 \
    control \
    md5sums \
    shlibs

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
      ${OUT_DIR}/deadbeef-${DEB_VERSION}-${DEB_BUILD}_${DEB_ARCH}_${DEB_DISTRO}.deb \
      debian-binary \
      control.tar.gz \
      data.tar.gz

