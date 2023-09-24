#!/bin/sh

export INSTALL_PREFIX=/opt/python
export gnuArch="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)"


wget -O Python-$PYTHON_VERSION.tar.xz "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz"
tar -xvf Python-$PYTHON_VERSION.tar.xz && cd Python-$PYTHON_VERSION


export EXTRA_CFLAGS="-DTHREAD_STACK_SIZE=0x100000"
export LDFLAGS="${LDFLAGS:--Wl},--strip-all"

export LOCAL_INCLUDES="-I/opt/shared_libraries/include/ncurses"
export LOCAL_INCLUDES="${LOCAL_INCLUDES} -I/opt/shared_libraries/include/" # some wired packages include ncurses.h or ncurses/ncurses.h

export CFLAGS="${CFLAGS} ${LOCAL_INCLUDES}"
export CPPFLAGS="${CPPFLAGS} ${LOCAL_INCLUDES}"
export LDFLAGS="${LDFLAGS} -L/opt/shared_libraries/lib -lffi"
./configure --build="$gnuArch" --enable-loadable-sqlite-extensions \
    --enable-optimizations --enable-option-checking=fatal --enable-shared \
    --with-lto --with-system-expat --without-ensurepip \
    --prefix="$INSTALL_PREFIX" --with-openssl-rpath=auto \
    --with-openssl=/opt/shared_libraries

make -j $(nproc)
rm python
make -j $(nproc) python
make install

# find /usr/local -type f -executable -not \( -name '*tkinter*' \) -exec scanelf --needed --nobanner --format '%n#p' '{}' ';' | tr ',' '\n' | sort -u | awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' | xargs -rt apk add --no-network --virtual .python-rundeps
# apk del --no-network .build-deps
export PYTHON_PATH=/opt/python/bin/python3

$PYTHON_PATH --version # buildkit
