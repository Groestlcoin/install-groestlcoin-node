#!/bin/bash

# Adapted from: https://www.ndchost.com/wiki/how-to-install-bitcoin-on-centos-7

BITCOIN_TAG="v0.16.0"

# Install the EPEL repository
sudo yum install -y epel-release

# Install requirements/dependencies
sudo yum install -y \
    autoconf \
    automake \
    boost-devel \
    gcc-c++ \
    git \
    libdb4-cxx \
    libdb4-cxx-devel \
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

# Download and compile bitcoin
cd ~
git clone https://github.com/bitcoin/bitcoin.git
cd ~/bitcoin
git checkout ${BITCOIN_TAG}
./autogen.sh
./configure --without-gui --disable-wallet --prefix=/opt/bitcoin-${BITCOIN_TAG} PKG_CONFIG_PATH=/opt/openssl/lib/pkgconfig LIBS=-Wl,-rpath,/opt/openssl/lib
make
sudo make install

cd ~
rm -rf bitcoin openssl

sudo ln -s /opt/bitcoin-${BITCOIN_TAG}/bin/bitcoind /usr/bin/bitcoind
sudo ln -s /opt/bitcoin-${BITCOIN_TAG}/bin/bitcoin-cli /usr/bin/bitcoin-cli
