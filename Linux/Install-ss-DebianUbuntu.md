https://github.com/shadowsocks/shadowsocks-qt5.wiki.git

https://github.com/shadowsocks/shadowsocks-qt5/wiki/Installation

Ubuntu

PPA is for Ubuntu >= 14.04.

sudo add-apt-repository ppa:hzwhuang/ss-qt5
sudo apt-get update
sudo apt-get install shadowsocks-qt5

Debian

Make sure you've installed all dependencies for building ss-qt5 by sudo apt-get install qt5-qmake qtbase5-dev libqrencode-dev libqtshadowsocks-dev libappindicator-dev libzbar-dev libbotan1.10-dev

Now run the command below, you'll get a deb package in upper directory.

dpkg-buildpackage -uc -us -b

Then, install it by sudo dpkg -i shadowsocks-qt5-<VER_ARCH_ETC>.deb.
