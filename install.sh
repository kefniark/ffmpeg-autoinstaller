#!/bin/sh

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

# Setup folders
CURRENT_DIR=`dirname $0`
BUILD_DIR="/usr/local/src/ffmpeg-build/"
BIN_DIR="/usr/local/src/ffmpeg-build/bin/"
TMP_DIR="/usr/local/src/ffmpeg-tmp/"

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
    # Pre compile
    source "$CURRENT_DIR/install_pre.sh"

    # install : Dependencies (
    source "$CURRENT_DIR/dependencies.sh"

    # install : Yasm
    source "$CURRENT_DIR/yasm.sh"

    # install : X264
    source "$CURRENT_DIR/x264.sh"

    # install : AAC
    source "$CURRENT_DIR/aac.sh"

    # install : VPX
    source "$CURRENT_DIR/vpx.sh"

    # install : FFMPEG
    source "$CURRENT_DIR/ffmpeg.sh"

    # Post compile
    source "$CURRENT_DIR/install_post.sh"

    # Finish
    echo 'FFmpeg installation finished successfully! Congrats!'
    exit 0
fi