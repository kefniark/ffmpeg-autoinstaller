#!/bin/sh

echo 'Downloading yasm'
wget http://www.tortall.net/projects/yasm/releases/yasm-1.2.0.tar.gz || ( echo 'Check internet connection...' && exit 1 )

tar xvzf yasm-1.2.0.tar.gz
cd yasm-1.2.0
./configure --prefix="$BUILD_DIR" --bindir="$BIN_DIR"
make
execRoot('checkinstall --pkgname=yasm --pkgversion="1.2.0" --backup=no --deldoc=yes --fstrans=no --default')
checkStatus()