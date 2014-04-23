#!/bin/bash

cd $TMP_DIR
echo 'x264 installation...'
sleep 2
git clone --depth 1 git://git.videolan.org/x264.git || ( echo 'Check internet connection...' && exit 1 )
cd x264
./configure --prefix="$BUILD_DIR" --bindir="$BIN_DIR" --enable-static
make
execRoot 'checkinstall --pkgname=x264 --pkgversion="3:$(./version.sh | awk -F'[" ]' '/POINT/{print $4"+git"$5}')" --deldoc=yes --fstrans=no --default'
checkStatus()