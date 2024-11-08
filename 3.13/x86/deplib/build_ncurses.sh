#!/bin/sh

set -e
export NCURSES_VERSION=6.5

wget http://core.ring.gr.jp/pub/GNU/ncurses/ncurses-${NCURSES_VERSION}.tar.gz
tar -xzf ncurses-${NCURSES_VERSION}.tar.gz && cd ncurses-${NCURSES_VERSION}

export CFLAGS="${CFLAGS} -fPIC -std=gnu11"
./configure --prefix=/opt/shared_libraries \
    --with-termlib=tinfo --with-shared --without-ada --disable-termcap --with-cxx-shared --with-cxx-binding --disable-setuid-environ \
    --enable-pc-files --disable-stripping --with-cxx-binding --with-xterm-kbs=del --with-versioned-syms --enable-widec
make -j $(nproc) && make install 
