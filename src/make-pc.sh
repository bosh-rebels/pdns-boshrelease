#!/bin/bash

prefix=${1:-/var/vcap/packages/lua}
pkgconfig_dir=$prefix/lib/pkgconfig
mkdir -p $pkgconfig_dir

cat <<EOF >${pkgconfig_dir}/lua.pc
V=5.3
R=5.3.5

prefix=${prefix:-/var/vcap/packages/lua}
INSTALL_BIN=${prefix}/bin
INSTALL_INC=${prefix}/include
INSTALL_LIB=${prefix}/lib
INSTALL_MAN=${prefix}/share/man/man1
INSTALL_LMOD=${prefix}/share/lua/${V}
INSTALL_CMOD=${prefix}/lib/lua/${V}
exec_prefix=${prefix}
libdir=${exec_prefix}/lib
includedir=${prefix}/include

Name: Lua
Description: An Extensible Extension Language
Version: ${R}
Requires:
Libs: -L${libdir} -llua -lm -ldl
Cflags: -I${includedir}
EOF