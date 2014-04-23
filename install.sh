#!/bin/bash

# Shell script for automated installation of FFmpeg from source.
# This script is based on the autoInstallFFmpeg-1.1 from pantuts (http://pantuts.com/2013/04/15/installffmpeg-sh-to-automate-ffmpeg-installation-from-source/)
#
# Credits and thanks to ffmpeg authors and contributors and third-party libraries
# Disclaimer: The script is provided "AS IS". This could contain technical inaccuracies.
# This script may be updated or changed without notice at any time. Use of the script
# is therefore at your own risk.
# Author will not be held liable for any damage that may occur.
#

# Setup parameters
CURRENT_DIR=`dirname $0`
PLUGIN_DIR="$CURRENT_DIR/plugins"
BUILD_DIR="/usr/local/src/ffmpeg-build/"
BIN_DIR="/usr/local/src/ffmpeg-build/bin/"
TMP_DIR="/usr/local/src/ffmpeg-tmp/"

function execRoot(){
    if [ $EUID -e 0 ]; then
        echo "execute as root user"
        $1
    else
        echo "execute as sudo user"
        sudo $1
    fi
}

function loadPlugin(){
    PLUGIN_FILE="plugins/$1"
    echo "Loading Plugin : $PLUGIN_FILE"
    source $PLUGIN_FILE
}

function checkStatus(){
    if [ $? -gt 0 ]; then
        echo 'Error/s encountered, exiting.'
        exit $?
    fi
}

set -e

if [ "$(whoami)" != "root" ]; then
    echo "You must be a superuser. Type sudo first before the script."
    exit 1
else
    # Pre compile
    loadPlugin "install_pre.sh"

    # install : Dependencies
    loadPlugin "dependencies.sh"

    # install : Yasm
    loadPlugin "yasm.sh"

    # install : X264
    loadPlugin "x264.sh"

    # install : AAC
    loadPlugin "aac.sh"

    # install : VPX
    loadPlugin "vpx.sh"

    # install : FFMPEG
    loadPlugin "ffmpeg.sh"

    # Post compile
    loadPlugin "install_post.sh"

    # Finish
    echo 'FFmpeg installation finished successfully! Congrats!'
    exit 0
fi