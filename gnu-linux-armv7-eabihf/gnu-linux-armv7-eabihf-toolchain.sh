#!/bin/bash

export BUILD_ARCH=${BUILD_ARCH:-armv7-eabihf}
ROOT_DIR=${1:-/opt/${BUILD_ARCH}}
mkdir -p $ROOT_DIR

#CHECK TOOL FOR DOWNLOAD
downloader () {
  local link=$1
  FILE=${link##*/}
  [ ! -f ${FILE} ] && wget -c $link
  [ ! -d ${FILE%%.tar*} ] && tar xf $FILE
  echo ${FILE%%.tar*}
}

#BUILD TOOLS FOR RASPBERRY
cd /tmp/
FILE='armv7-eabihf--glibc--stable-2018.11-1.tar.bz2'
downloader https://toolchains.bootlin.com/downloads/releases/toolchains/armv7-eabihf/tarballs/$FILE

mkdir -p ${ROOT_DIR}/toolchain
tar xf $FILE -C ${ROOT_DIR}/toolchain --strip-components=1
