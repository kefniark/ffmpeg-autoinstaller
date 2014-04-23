ffmpeg-autoinstaller
====================

A simple autoinstaller of ffmpeg for debian/ubuntu
It was test on :
   debian squeeze
   debian wheezy

How to get it

    git-clone https://github.com/kefniark/ffmpeg-autoinstaller.git
    cd ffmpeg-autoinstaller

To make it executable

    +x install.sh

and run it

    ./install.sh

If you don't have all apt depedencies (libfaac-dev, libgpac-dev, ...) you can add the multimedia repository

    apt-get install deb-multimedia-keyring
    echo "deb http://www.deb-multimedia.org wheezy main non-free" >> /etc/apt/sources.list.d/multimedia.list
    echo "deb-src http://www.deb-multimedia.org wheezy main non-free" >> /etc/apt/sources.list.d/multimedia.list
    apt-get update

For more informations : http://www.deb-multimedia.org/