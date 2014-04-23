#!/bin/bash

echo 'Removing existing packages...'
if [ $IS_ROOT -eq 1 ]; then
    apt-get remove ffmpeg x264 libav-tools libvpx-dev libx264-dev yasm -y || true
else
    sudo apt-get remove ffmpeg x264 libav-tools libvpx-dev libx264-dev yasm -y || true
fi

# Clean old install
if [ -d "$BUILD_DIR" ]; then
    echo "Clean Folder $BUILD_DIR"
    rm -R $BUILD_DIR
fi
if [ -d "$TMP_DIR" ]; then
    echo "Clean Folder $TMP_DIR"
    rm -R $TMP_DIR
fi
echo "Create Folder $TMP_DIR"
mkdir $TMP_DIR
cd $TMP_DIR