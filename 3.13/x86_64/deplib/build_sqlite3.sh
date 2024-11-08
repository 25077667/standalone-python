#!/bin/sh

set -e
export OPENSSL_VERSION=3470000

# Get https://www.sqlite.org/2024/sqlite-autoconf-3470000.tar.gz
wget https://www.sqlite.org/2024/sqlite-autoconf-${OPENSSL_VERSION}.tar.gz
tar -zxvf sqlite-autoconf-${OPENSSL_VERSION}.tar.gz && cd sqlite-autoconf-${OPENSSL_VERSION}

export LOCAL_INCLUDES="-I/opt/shared_libraries/include/ncurses"
export LOCAL_INCLUDES="${LOCAL_INCLUDES} -I/opt/shared_libraries/include/" # some wired packages include ncurses.h or ncurses/ncurses.h

export CFLAGS="${CFLAGS} ${LOCAL_INCLUDES}"
export LDFLAGS="${LDFLAGS} -L/opt/shared_libraries/lib"

./configure --prefix=/opt/shared_libraries
make -j $(nproc) && make install
