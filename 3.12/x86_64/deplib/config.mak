TARGET = x86_64-linux-musl
GCC_VER = 13.2.0
MUSL_VER = 1.2.4
COMMON_CONFIG += CFLAGS="-g0 -O3" CXXFLAGS="-g0 -O3" LDFLAGS="-s"
GCC_CONFIG += --enable-default-pie --enable-static-pie
