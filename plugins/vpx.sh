#!/bin/sh

cd $TMP_DIR
echo 'libvpx installation...'
sleep 2
git clone --depth 1 http://git.chromium.org/webm/libvpx.git || ( echo 'Check internet connection...' && exit 1 )
cd libvpx
./configure --prefix="$BUILD_DIR" --disable-examples
make
sudo checkinstall --pkgname=libvpx --pkgversion="1:$(date +%Y%m%d%H%M)-git" --backup=no --deldoc=yes --fstrans=no --default
checkStatus()