#!/bin/sh

set -e
export MPDECIMAL_VERSION=4.0.0

wget https://www.bytereef.org/software/mpdecimal/releases/mpdecimal-${MPDECIMAL_VERSION}.tar.gz
tar -xvf mpdecimal-${MPDECIMAL_VERSION}.tar.gz && cd mpdecimal-${MPDECIMAL_VERSION}

export CFLAGS="${CFLAGS} -fPIC"
./configure --prefix=/opt/shared_libraries
make -j $(nproc) && make install
