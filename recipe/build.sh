#!/bin/bash -euo

set -xe

# If building for in Linux, set the `$HOSTCC` manually to
# avoid calling the hardcoded `cc` command in the makefile
# If building for `osx-arm64` use `$CC_FOR_BUILD` for `HOSTCC` and `$CC` for `CC`.
# This is because the `osx-arm64` build is cross-compiled from `osx_64`
if [[ "${target_platform}" == linux-* || "${target_platform}" == osx-arm64 ]]; then
    make HOSTCC="$CC_FOR_BUILD -g -Wall -pedantic -Wcast-qual" CC="$CC -g -Wall -pedantic -Wcast-qual"
else
    make
fi

if [ ! -d ${PREFIX}/bin ] ; then
    mkdir -p ${PREFIX}/bin
fi

mv a.out ${PREFIX}/bin/awk
