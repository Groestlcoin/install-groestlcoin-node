#!/bin/bash

# Adapted from: https://www.ndchost.com/wiki/how-to-install-bitcoin-on-centos-7

GROESTLCOIN_TAG="v2.16.3"

# Install the EPEL repository
sudo yum install -y epel-release

# Install requirements/dependencies
sudo yum install -y \
    autoconf \
    automake \
    boost-devel \
    gcc-c++ \
    git \
    libdb-cxx \
    libdb-cxx-devel \
    libevent-devel \
    libtool \
    openssl-devel \
    wget

# From https://www.ndchost.com/wiki/how-to-install-bitcoin-on-centos-7
#
# Compile and install OpenSSL (Unfortunately the openssl thats provided with
# CentOS is lacking EC Libraries so we are going to have to download, build, and
# install a separate copy of OpenSSL)
cd ~
mkdir openssl
cd openssl
wget https://www.openssl.org/source/openssl-1.0.1l.tar.gz
tar zxvf openssl-1.0.1l.tar.gz
cd openssl-1.0.1l
export CFLAGS="-fPIC"
./config --prefix=/opt/openssl shared enable-ec enable-ecdh enable-ecdsa
make all
sudo make install

# Download and compile groestlcoin
cd ~
git clone https://github.com/groestlcoin/groestlcoin.git
cd ~/groestlcoin
git checkout ${GROESTLCOIN_TAG}
./autogen.sh
./configure --without-gui --disable-wallet --prefix=/opt/groestlcoin-${GROESTLCOIN_TAG} PKG_CONFIG_PATH=/opt/openssl/lib/pkgconfig LIBS=-Wl,-rpath,/opt/openssl/lib
make
sudo make install

cd ~
rm -rf groestlcoin openssl

sudo ln -s /opt/groestlcoin-${GROESTLCOIN_TAG}/bin/groestlcoind /usr/bin/groestlcoind
sudo ln -s /opt/groestlcoin-${GROESTLCOIN_TAG}/bin/groestlcoin-cli /usr/bin/groestlcoin-cli
