#!/bin/bash

set +e

BUILD_ARCH=${BUILD_ARCH:-armv7-eabihf}
ARIA2_ver=${ARIA2_ver:-"1.35.0"}

ROOT_DIR="/opt/${BUILD_ARCH}"
REPO_DIR=`pwd`

cd "gnu-linux-${BUILD_ARCH}"
bash gnu-linux-${BUILD_ARCH}-toolchain.sh $ROOT_DIR
bash gnu-linux-${BUILD_ARCH}-libs.sh $ROOT_DIR
bash gnu-linux-${BUILD_ARCH}-aria2.sh $ROOT_DIR
tar -czvf  aria2-${BUILD_ARCH}-${ARIA2_ver}.tar.gz aria2c
mv aria2-${BUILD_ARCH}-${ARIA2_ver}.tar.gz $REPO_DIR/
cd $REPO_DIR
