#!/bin/sh

cd $TMP_DIR
echo 'Updating sources...'
sleep 1
execRoot('apt-get update')
checkStatus()

echo 'Installing dependencies. Please wait...'
sleep 2
execRoot('apt-get -y install autoconf automake build-essential checkinstall git libass-dev libfaac-dev \
    libgpac-dev libjack-jackd2-dev libmp3lame-dev libopencore-amrnb-dev libopencore-amrwb-dev libopus-dev \
    librtmp-dev libsdl1.2-dev libspeex-dev libtheora-dev libtool libva-dev libvdpau-dev libvorbis-dev \
    libx11-dev libxext-dev libxfixes-dev pkg-config texi2html zlib1g-dev -y')
checkStatus()