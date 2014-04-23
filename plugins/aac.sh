#!/bin/sh

cd $TMP_DIR
echo 'fdk-aac installation...'
sleep 2
git clone --depth 1 git://github.com/mstorsjo/fdk-aac.git || ( echo 'Check internet connection...' && exit 1 )
cd fdk-aac
autoreconf -fiv
./configure --prefix="$BUILD_DIR" --disable-shared
make
execRoot('checkinstall --pkgname=fdk-aac --pkgversion="$(date +%Y%m%d%H%M)-git" --backup=no --deldoc=yes --fstrans=no --default')
checkStatus()