FROM alpine:latest as base_builder

ENV PATH=/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
    LANG=C.UTF-8 \
    PYTHON_VERSION=3.13.0

WORKDIR /src
RUN set -eux && apk add --no-cache ca-certificates tzdata && \
    apk add --no-cache --virtual .build-deps tar xz bluez-dev dpkg-dev dpkg findutils gcc file g++ \
        libc-dev libnsl-dev libtirpc-dev linux-headers make pax-utils tk tk-dev util-linux-dev wget \
        bison flex gawk patch

# # =========== musl ===========
FROM debian:bookworm as musl_builder
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Taipei

RUN apt-get update -y && apt-get upgrade -y && \
    apt-get install -y build-essential wget git file tar xz-utils dpkg-dev libnsl-dev libtirpc-dev uuid-dev patch

WORKDIR /src
COPY ["./deplib/build_musl.sh", "./deplib/config.mak", "."]
RUN set -eux && ./build_musl.sh

# =========== libz ===========
FROM base_builder as libz_builder
COPY ["./deplib/build_zlib.sh", "."]
RUN set -eux && ./build_zlib.sh

# =========== ffi ===========
FROM libz_builder as ffi_builder
COPY ["./deplib/build_ffi.sh", "."]
RUN set -eux && ./build_ffi.sh

# =========== expat ===========
FROM ffi_builder as expat_builder
COPY ["./deplib/build_expat.sh", "."]
RUN set -eux && ./build_expat.sh

# =========== gdbm ===========
FROM expat_builder as gdbm_builder
COPY ["./deplib/build_gdbm.sh", "."]
RUN set -eux && ./build_gdbm.sh

# =========== lzma ===========
FROM gdbm_builder as lzma_builder
COPY ["./deplib/build_lzma.sh", "."]
RUN set -eux && ./build_lzma.sh

# =========== gettext ===========
FROM lzma_builder as gettext_builder
COPY ["./deplib/build_gettext.sh", "."]
RUN set -eux && ./build_gettext.sh

# =========== ncurses ===========
FROM gettext_builder as ncurses_builder
COPY ["./deplib/build_ncurses.sh", "."]
RUN set -eux && ./build_ncurses.sh

# =========== openssl ===========
FROM ncurses_builder as openssl_builder
COPY ["./deplib/build_openssl.sh", "."]
RUN set -eux && ./build_openssl.sh

# =========== readline ===========
FROM openssl_builder as readline_builder
COPY ["./deplib/build_readline.sh", "./deplib/patch/fix-ncurses-underlinking.patch",  "."]
RUN set -eux && ./build_readline.sh

# =========== tcl ===========
FROM readline_builder as tcl_builder
COPY ["./deplib/build_tcl.sh", "."]
RUN set -eux && ./build_tcl.sh

# =========== tk ===========
FROM tcl_builder as tk_builder
COPY ["./deplib/build_tk.sh", "."]
RUN set -eux && ./build_tk.sh

# =========== xz ===========
FROM tk_builder as xz_builder
COPY ["./deplib/build_xz.sh", "."]
RUN set -eux && ./build_xz.sh

# =========== bzip2 ===========
FROM xz_builder as bzip2_builder
COPY ["./deplib/build_bzip2.sh", "."]
RUN set -eux && ./build_bzip2.sh

# =========== sqlite3 ===========
FROM bzip2_builder as sqlite3_builder
COPY ["./deplib/build_sqlite3.sh", "."]
RUN set -eux && ./build_sqlite3.sh

# =========== mpdecimal ===========
FROM sqlite3_builder as mpdecimal_builder
COPY ["./deplib/build_mpdecimal.sh", "."]
RUN set -eux && ./build_mpdecimal.sh

# =========== Python ===========
FROM mpdecimal_builder as python_builder

COPY ["./deplib/build_python.sh", "./deplib/install_pip.sh", "."]
RUN set -eux && ./build_python.sh && ./install_pip.sh

# =========== patch_stage ===========
FROM debian:latest as patch_stage
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Taipei

RUN apt-get update -y && apt-get install -y patchelf file

COPY --from=python_builder /opt/shared_libraries /opt/shared_libraries
COPY --from=python_builder /opt/python /opt/python

COPY ["./packing-initializer", "./python-wrapper", "./pip-wrapper","."]
RUN ./packing-initializer && rm -rf packing-initializer && \
    mv python-wrapper /opt/python/bin/python3 && \
    mv pip-wrapper /opt/python/bin/pip3 && \
    cd  /opt/python/bin && \
    ln -sf python3 python && \
    ln -sf pip3 pip

# Patch the generated python and related dynamic libraries
COPY --from=musl_builder /opt/musl /opt/musl
COPY ["./interpreter-patcher.sh", "."]
RUN set -eux && ./interpreter-patcher.sh 

# =========== final ===========
FROM debian:latest as final
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Taipei

COPY --from=patch_stage /opt/python /opt/python