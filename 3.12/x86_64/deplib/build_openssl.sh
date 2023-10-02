#!/bin/sh

set -e
export OPENSSL_VERSION=1.1.1w

wget https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz
tar -xvf openssl-${OPENSSL_VERSION}.tar.gz && cd openssl-${OPENSSL_VERSION}

./config --prefix=/opt/shared_libraries
make -j $(nproc) && make install
