#!/bin/bash

cd $TMP_DIR
echo 'Updating sources...'
sleep 1
if [ $IS_ROOT -eq 1 ]; then
    apt-get update
else
    sudo apt-get update
fi
checkStatus

echo 'Installing dependencies. Please wait...'
sleep 1
if [ $IS_ROOT -eq 1 ]; then
    apt-get -y install autoconf automake build-essential checkinstall git libass-dev libfaac-dev libgpac-dev libjack-jackd2-dev libmp3lame-dev libopencore-amrnb-dev libopencore-amrwb-dev librtmp-dev libsdl1.2-dev libspeex-dev libtheora-dev libtool libva-dev libvdpau-dev libvorbis-dev libx11-dev libxext-dev libxfixes-dev pkg-config texi2html zlib1g-dev -y
else
    sudo apt-get -y install autoconf automake build-essential checkinstall git libass-dev libfaac-dev libgpac-dev libjack-jackd2-dev libmp3lame-dev libopencore-amrnb-dev libopencore-amrwb-dev librtmp-dev libsdl1.2-dev libspeex-dev libtheora-dev libtool libva-dev libvdpau-dev libvorbis-dev libx11-dev libxext-dev libxfixes-dev pkg-config texi2html zlib1g-dev -y
fi
checkStatus