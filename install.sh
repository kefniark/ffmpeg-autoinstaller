#!/usr/bin/sh

# Shell script for automated installation of FFmpeg from source.
# This script is based on the autoInstallFFmpeg-1.1 from pantuts (http://pantuts.com/2013/04/15/installffmpeg-sh-to-automate-ffmpeg-installation-from-source/)
#
# Credits and thanks to ffmpeg authors and contributors and third-party libraries
# Disclaimer: The script is provided “AS IS”. This could contain technical inaccuracies.
# This script may be updated or changed without notice at any time. Use of the script
# is therefore at your own risk.
# Author will not be held liable for any damage that may occur.
#

set -e

checkStatus(){
    if [ $? -gt 0 ]; then
        echo 'Error/s encountered, exiting.'
        exit $?
    fi
}

if [ "$(whoami)" != "root" ]; then
    echo "You must be a superuser. Type sudo first before the script."
    exit 1
else
    echo 'Removing existing packages...'
    sudo apt-get remove ffmpeg x264 libav-tools libvpx-dev libx264-dev yasm -y
    checkStatus()

    echo 'Updating sources...'
    sleep 1
    sudo apt-get update
    checkStatus()

    echo 'Installing dependencies. Please wait...'
    sleep 2
    sudo apt-get -y install autoconf automake build-essential checkinstall git libass-dev libfaac-dev \
        libgpac-dev libjack-jackd2-dev libmp3lame-dev libopencore-amrnb-dev libopencore-amrwb-dev libopus-dev \
        librtmp-dev libsdl1.2-dev libspeex-dev libtheora-dev libtool libva-dev libvdpau-dev libvorbis-dev \
        libx11-dev libxext-dev libxfixes-dev pkg-config texi2html zlib1g-dev -y
    checkStatus()

    echo 'Yasm configuration and installation...'
    sleep 2

    buildDIR="/usr/local/src/ffmpeg-build/"
    tmpDIR="/usr/local/src/ffmpeg-tmp/"

    # Clean old install
    if [ -d "$buildDIR" ]; then
        echo "Clean Folder $buildDIR"
        rm -R $buildDIR
    fi
    if [ -d "$tmpDIR" ]; then
        echo "Clean Folder $tmpDIR"
        rm -R $tmpDIR
    fi
    mkdir $tmpDIR
    cd $tmpDIR

    echo 'Downloading yasm'
    wget http://www.tortall.net/projects/yasm/releases/yasm-1.2.0.tar.gz || ( echo 'Check internet connection...' && exit 1 )

    tar xvzf yasm-1.2.0.tar.gz
    cd yasm-1.2.0
    ./configure --prefix="$buildDIR" --bindir="$HOME/bin"
    make
    sudo checkinstall --pkgname=yasm --pkgversion="1.2.0" --backup=no --deldoc=yes --fstrans=no --default
    checkStatus()

    cd $tmpDIR
    echo 'x264 installation...'
    sleep 2
    git clone --depth 1 git://git.videolan.org/x264.git || ( echo 'Check internet connection...' && exit 1 )
    cd x264
    ./configure --prefix="$buildDIR" --bindir="$HOME/bin" --enable-static
    make
    sudo checkinstall --pkgname=x264 --pkgversion="3:$(./version.sh | awk -F'[" ]' '/POINT/{print $4"+git"$5}')" --deldoc=yes --fstrans=no --default
    checkStatus()

    cd $tmpDIR
    echo 'fdk-aac installation...'
    sleep 2
    git clone --depth 1 git://github.com/mstorsjo/fdk-aac.git || ( echo 'Check internet connection...' && exit 1 )
    cd fdk-aac
    autoreconf -fiv
    ./configure --prefix="$buildDIR" --disable-shared
    make
    sudo checkinstall --pkgname=fdk-aac --pkgversion="$(date +%Y%m%d%H%M)-git" --backup=no --deldoc=yes --fstrans=no --default
    checkStatus()

    cd $tmpDIR
    echo 'libvpx installation...'
    sleep 2
    git clone --depth 1 http://git.chromium.org/webm/libvpx.git || ( echo 'Check internet connection...' && exit 1 )
    cd libvpx
    ./configure --prefix="$buildDIR" --disable-examples
    make
    sudo checkinstall --pkgname=libvpx --pkgversion="1:$(date +%Y%m%d%H%M)-git" --backup=no --deldoc=yes --fstrans=no --default
    checkStatus()

    cd $tmpDIR
    echo 'Final installation for ffmpeg...'
    sleep 2
    git clone --depth 1 git://source.ffmpeg.org/ffmpeg || ( echo 'Check internet connection...' && exit 1 )
    cd ffmpeg
    PKG_CONFIG_PATH="$buildDIR/lib/pkgconfig"
    ./configure --prefix="$buildDIR" \
    --extra-cflags="-I$buildDIR/include" --extra-ldflags="-L$buildDIR/lib" \
    --bindir="$HOME/bin" --extra-libs="-ldl" --enable-gpl --enable-libass --enable-libfaac \
    --enable-libfdk-aac --enable-libmp3lame --enable-libopencore-amrnb --enable-libopencore-amrwb \
    --enable-libspeex --enable-librtmp --enable-libtheora --enable-libvorbis --enable-libvpx \
    --enable-x11grab --enable-libx264 --enable-nonfree --enable-version3 --enable-libopus
    make
    sudo checkinstall --pkgname=ffmpeg --pkgversion="7:$(date +%Y%m%d%H%M)-git" --backup=no --deldoc=yes --fstrans=no --default
    checkStatus()
    echo
    sleep 1

    echo 'Removing tmp build files...'
    sleep 1
    sudo rm -rf $tmpDIR
    echo 'FFmpeg installation finished successfully! Congrats!'
    exit 0
fi