#!/bin/bash

cd $TMP_DIR
echo 'fdk-aac installation...'
sleep 1
git clone --depth 1 git://github.com/mstorsjo/fdk-aac.git || ( echo 'Check internet connection...' && exit 1 )
cd fdk-aac
autoreconf -fiv
./configure --prefix="$BUILD_DIR" --disable-shared
make
if [ $IS_ROOT -eq 1 ]; then
    checkinstall --pkgname=fdk-aac --pkgversion="1:$(date +%Y%m%d%H%M)-git" --deldoc=yes --fstrans=no --default
else
    sudo checkinstall --pkgname=fdk-aac --pkgversion="1:$(date +%Y%m%d%H%M)-git" --deldoc=yes --fstrans=no --default
fi
checkStatus