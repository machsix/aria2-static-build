#!/bin/bash

# In this configuration, the following dependent libraries are compiled:
#
# * zlib
# * c-ares
# * expat
# * sqlite3
# * openSSL
# * libssh2
set +e
BUILD_ARCH=${BUILD_ARCH:-armv7-eabihf}
ROOT_DIR=${1:-/opt/${BUILD_ARCH}}
PREFIX="${ROOT_DIR}/build_libs"
BUILD_DIRECTORY=/tmp/
## Enviroment Variables ##
source source.sh $ROOT_DIR
MAKE="make -j`nproc`"
ARCH="armhf"
## DEPENDENCES ##
ZLIB=https://www.zlib.net/zlib-1.2.11.tar.gz
OPENSSL=https://www.openssl.org/source/openssl-1.0.2t.tar.gz
EXPAT=https://github.com/libexpat/libexpat/releases/download/R_2_2_6/expat-2.2.6.tar.bz2
LIBXML2=http://xmlsoft.org/sources/libxml2-2.9.9.tar.gz
SQLITE3=https://sqlite.org/2019/sqlite-autoconf-3300000.tar.gz
C_ARES=http://c-ares.haxx.se/download/c-ares-1.15.0.tar.gz
SSH2=https://www.libssh2.org/download/libssh2-1.7.0.tar.gz

downloader () {
  local link=$1
  FILE=${link##*/}
  [ ! -f ${FILE} ] && wget -c $link
  [ ! -d ${FILE%%.tar*} ] && tar xf $FILE
  echo ${FILE%%.tar*}
}

build_zlib () {
  cd $BUILD_DIRECTORY
  FOLDER=$(downloader $ZLIB)
  cd $FOLDER
  ./configure --prefix=$PREFIX
  $MAKE > /dev/null
  make install
}

build_libxml () {
  cd $BUILD_DIRECTORY
  FOLDER=$(downloader ${LIBXML2})
  cd $FOLDER
  ./configure --host=$TARGET_HOST \
              --prefix=$PREFIX \
              --enable-static=yes \
              --enable-shared=no \
              --without-python
  $MAKE > /dev/null
  make install
}

build_expat () {
  cd $BUILD_DIRECTORY
  FOLDER=$(downloader $EXPAT)
  cd $FOLDER
  ./configure --host=$TARGET_HOST \
              --prefix=$PREFIX \
              --enable-static=yes \
              --enable-shared=no
  $MAKE > /dev/null
  make install
}
build_expat () {
  cd $BUILD_DIRECTORY
  FOLDER=$(downloader $EXPAT)
  cd $FOLDER
  ./configure --host=$TARGET_HOST \
              --prefix=$PREFIX \
              --enable-static=yes \
              --enable-shared=no
  $MAKE > /dev/null
  make install
}

build_cares () {
  cd $BUILD_DIRECTORY
  FOLDER=$(downloader $C_ARES)
  cd $FOLDER
  ./configure --host=$TARGET_HOST \
              --prefix=$PREFIX \
              --enable-static \
              --disable-shared
  $MAKE > /dev/null
  make install
}

build_openssl () {
  cd $BUILD_DIRECTORY
  FOLDER=$(downloader $OPENSSL)
  cd $FOLDER
  ./Configure linux-generic32 \
             --prefix=$PREFIX shared zlib zlib-dynamic \
             --with-zlib-lib=$PREFIX/lib \
             --with-zlib-include=$PREFIX/include
  $MAKE CC=$CC > /dev/null
  $MAKE CC=$CC install
}

build_sqlite () {
  cd $BUILD_DIRECTORY
  FOLDER=$(downloader $SQLITE3)
  cd $FOLDER
  ./configure --host=$TARGET_HOST \
              --prefix=$PREFIX \
              --enable-static --enable-shared
  $MAKE CC=$CC > /dev/null
  make install CC=$CC
}

build_libssh () {
  cd $BUILD_DIRECTORY
  FOLDER=$(downloader $SSH2)
  cd $FOLDER
  LD_LIBRARY_PATH=$PREFIX/lib ./configure --host=$TARGET_HOST \
              --without-libgcrypt \
              --with-openssl \
              --without-wincng \
              --prefix=$PREFIX \
              --enable-static --disable-shared \
              --with-libssl-prefix=$PREFIX
  $MAKE LIBS="-lz -lssl -lcrypto" CC=$CC > /dev/null
  make install CC=$CC
}
set +e
build_zlib
#build_expat
build_libxml
build_cares
build_sqlite
build_openssl
build_libssh
