#!/bin/bash -e
# set enviromental variables for toolchain
# syntax: source source.sh TARGET_HOST TOOL_CHAIN_DIR
unset ARCH
unset TARGET_HOST

unset CROSS_COMPILE
unset CC
unset CXX
unset AS
unset AR
unset LD
unset NM
unset RANLIB
unset STRIP
unset BASECFLAGS
unset PKG_CONFIG
export BUILD_ARCH=${BUILD_ARCH:-armv7-eabihf}
export ROOT_DIR=${1:-/opt/${BUILD_ARCH}}
export MYARCH=`arch`
export MYBUILD="x86_64"

export ARCH=armv7-a
export TUNE=cortex-a9
export TARGET_HOST=arm-buildroot-linux-gnueabihf
export DEB_HOST_MULTIARCH=arm-linux-gnueabihf

export PATH=$ROOT_DIR/toolchain/bin:$PATH
export CROSS_COMPILE=${TARGET_HOST}-
export CROSS=${TARGET_HOST}
export PKG_CONFIG=`which pkg-config`
export PKG_CONFIG_PATH="${ROOT_DIR}/build_libs/lib/pkgconfig"
export PKG_CONFIG_SYSROOT_DIR="/"
export CC=${CROSS_COMPILE}gcc
export CXX=${CROSS_COMPILE}g++
export AS=${CROSS_COMPILE}as
export AR=${CROSS_COMPILE}ar
export LD=${CROSS_COMPILE}ld
export NM=${CROSS_COMPILE}nm
export GDB=${CROSS_COMPILE}gdb
export RANLIB=${CROSS_COMPILE}ranlib
export STRIP=${CROSS_COMPILE}strip
export BASECFLAGS="-march="$ARCH" -mtune="$TUNE
export LD_LIBRARY_PATH=${ROOT_DIR}/tollchain/lib:${LD_LIBRARY_PATH}
