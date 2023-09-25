#!/bin/sh

# https://github.com/libexpat/libexpat/releases/download/R_2_5_0/expat-2.5.0.tar.gz
set -e
export EXPAT_VERSION=2.5.0
export EXPAT_LITERIAL_VERSION=2_5_0

wget https://github.com/libexpat/libexpat/releases/download/R_${EXPAT_LITERIAL_VERSION}/expat-${EXPAT_VERSION}.tar.gz

tar -xzf expat-${EXPAT_VERSION}.tar.gz && cd expat-${EXPAT_VERSION}
./configure --prefix=/opt/shared_libraries
make -j $(nproc) && make install
