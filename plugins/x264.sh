#!/bin/bash

cd $TMP_DIR
echo 'x264 installation...'
sleep 1
git clone --depth 1 git://git.videolan.org/x264.git || ( echo 'Check internet connection...' && exit 1 )
cd x264
./configure --prefix="$BUILD_DIR" --bindir="$BIN_DIR" --enable-static
make
if [ $IS_ROOT -eq 1 ]; then
    checkinstall --pkgname=x264 --pkgversion="1:$(date +%Y%m%d%H%M)-git" --deldoc=yes --fstrans=no --default
else
    sudo checkinstall --pkgname=x264 --pkgversion="1:$(date +%Y%m%d%H%M)-git" --deldoc=yes --fstrans=no --default
fi
checkStatus