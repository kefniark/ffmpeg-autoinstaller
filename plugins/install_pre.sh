#!/bin/bash

echo 'Removing existing packages...'
execRoot 'apt-get remove ffmpeg x264 libav-tools libvpx-dev libx264-dev yasm -y'
checkStatus()

# Clean old install
if [ -d "$BUILD_DIR" ]; then
    echo "Clean Folder $BUILD_DIR"
    rm -R $BUILD_DIR
fi
if [ -d "$TMP_DIR" ]; then
    echo "Clean Folder $TMP_DIR"
    rm -R $TMP_DIR
fi
mkdir $TMP_DIR
cd $TMP_DIR