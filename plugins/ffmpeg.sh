#!/bin/bash

cd $TMP_DIR
echo 'Final installation for ffmpeg...'
sleep 2
git clone --depth 1 git://source.ffmpeg.org/ffmpeg || ( echo 'Check internet connection...' && exit 1 )
cd ffmpeg
PKG_CONFIG_PATH="$BUILD_DIR/lib/pkgconfig"
./configure --prefix="$BUILD_DIR" \
--extra-cflags="-I$BUILD_DIR/include" --extra-ldflags="-L$BUILD_DIR/lib" \
--bindir="$BIN_DIR" --extra-libs="-ldl" --enable-gpl --enable-libass --enable-libfaac \
--enable-libfdk-aac --enable-libmp3lame --enable-libopencore-amrnb --enable-libopencore-amrwb \
--enable-libspeex --enable-librtmp --enable-libtheora --enable-libvorbis --enable-libvpx \
--enable-x11grab --enable-libx264 --enable-nonfree --enable-version3 --enable-libopus
make
execRoot 'checkinstall --pkgname=ffmpeg --pkgversion="7:$(date +%Y%m%d%H%M)-git" --backup=no --deldoc=yes --fstrans=no --default'
checkStatus
echo