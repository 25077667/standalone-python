#!/bin/sh

set -e
export TK_VERSION=8.6.15
# http://prdownloads.sourceforge.net/tcl/tk8.6.15-src.tar.gz

wget http://prdownloads.sourceforge.net/tcl/tk${TK_VERSION}-src.tar.gz
tar -xzf tk${TK_VERSION}-src.tar.gz && cd tk${TK_VERSION}/unix

./configure --prefix=/opt/shared_libraries --with-tcl=/opt/shared_libraries/lib
make -j $(nproc) && make install
