#!/bin/bash

cd $TMP_DIR
echo 'libvpx installation...'
sleep 1
git clone http://git.chromium.org/webm/libvpx.git || ( echo 'Check internet connection...' && exit 1 )
cd libvpx
./configure --prefix="$BUILD_DIR" --disable-examples
make
if [ $IS_ROOT -eq 1 ]; then
    checkinstall --pkgname=libvpx --pkgversion="1:$(date +%Y%m%d%H%M)-git" --backup=no --deldoc=yes --fstrans=no --default
else
    sudo checkinstall --pkgname=libvpx --pkgversion="1:$(date +%Y%m%d%H%M)-git" --backup=no --deldoc=yes --fstrans=no --default
fi
checkStatus