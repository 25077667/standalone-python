#!/bin/sh

# set -e
# TODO: Bump SSL version to 3.x
export OPENSSL_VERSION=1.1.1w

wget https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz
tar -xvf openssl-${OPENSSL_VERSION}.tar.gz && cd openssl-${OPENSSL_VERSION}

if [ "$IS_32BIT" = "0" ]; then
    ./config --prefix=/opt/shared_libraries
    make -j $(nproc) && make install
elif [ "$IS_32BIT" = "1" ]; then
    ./Configure linux-generic32 --shared --prefix=/opt/shared_libraries
    make -j $(nproc) && make install
else 
    echo "IS_32BIT is set to an invalid value"
    exit 1
fi
