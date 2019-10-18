#!/bin/bash

# In this configuration, the following dependent libraries are used:
#
# * zlib
# * c-ares
# * expat
# * sqlite3
# * openSSL
# * libssh2

## CONFIG ##
export BUILD_ARCH=${BUILD_ARCH:-armv7-eabihf}
export ROOT_DIR=${1:-/opt/${BUILD_ARCH}}

ARIA2_ver=${ARIA2_ver:-"1.35.0"}
source source.sh $ROOT_DIR

ARCH="armhf"
PREFIX="${ROOT_DIR}/build_libs"
MAKE="make -j`nproc`"

downloader () {
  local link=$1
  FILE=${link##*/}
  [ ! -f ${FILE} ] && wget -c $link
  [ ! -d ${FILE%%.tar*} ] && tar xf $FILE
  echo ${FILE%%.tar*}
}

patch_aria2 () {
  sed -i "s|built by|built by machsix @|" src/FeatureConfig.cc
  patch -b -p1 -i $PATCH_DIR/aria2-0002-options-unlock-connection-per-server-limit.patch
  patch -b -p1 -i $PATCH_DIR/aria2-0003-download-retry-on-slow-speed-and-reset.patch
  patch -b -p1 -i $PATCH_DIR/aria2-0005-option-add-option-to-retry-on-http-4xx.patch
}

config_aria2 () {
  ARIA2_STATIC=yes  ./configure --host=$TARGET_HOST \
      --enable-static \
      --disable-shared \
      --without-libuv \
      --without-appletls \
      --without-gnutls \
      --without-libnettle \
      --without-libgmp \
      --without-libgcrypt \
      --with-libxml2 \
      --with-ca-bundle=/etc/ssl/certs/ca-certificates.crt \
      --prefix=$PREFIX
    # OPENSSL_LIBS="-L${PREFIX}/lib" \
    # LIBCARES_CFLAGS="-I${PREFIX}/include" \
    # LIBCARES_LIBS="-L${PREFIX}/lib" \
    # LIBSSH2_CFLAGS="-I${PREFIX}/include" \
    # LIBSSH2_LIBS="-L${PREFIX}/lib" \
    # EXPAT_CFLAGS="-I${PREFIX}/include" \
    # EXPAT_LIBS="-L${PREFIX}/lib"
}

make_aria2 () {
  ${MAKE} LIBS="-lz -lssl -lcrypto -lsqlite3 -lcares -lxml2 -lssh2 -ldl"
  make install
}


THISDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
PATCH_DIR=`realpath $THISDIR/../patches`

cd /tmp
FOLDER=$(downloader https://github.com/aria2/aria2/releases/download/release-${ARIA2_ver}/aria2-${ARIA2_ver}.tar.bz2)

cd $FOLDER
patch_aria2
config_aria2
make_aria2
#
cd $THISDIR
cp -vf ${PREFIX}/bin/aria2c ./
arm-linux-strip aria2c
