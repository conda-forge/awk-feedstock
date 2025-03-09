#!/bin/bash -euo

set -xe

# If running in Linux, set the `$HOSTCC` manually to
# avoid calling the hardcoded `cc` command in the makefile
if [[ "${target_platform}" == linux-* ]]; then
    make HOSTCC="$CC -g -Wall -pedantic -Wcast-qual"
# If building for `osx-arm64` use `cc` for `HOSTCC` and `$CC` for `CC`.
# This is because the `osx-arm64` build is cross-compiled from `osx_64`
elif [[ "${target_platform}" == osx-arm64 ]]; then
    make HOSTCC="$CC_FOR_BUILD -g -Wall -pedantic -Wcast-qual" CC="$CC -g -Wall -pedantic -Wcast-qual"
else
    make
fi

if [ ! -d ${PREFIX}/bin ] ; then
    mkdir -p ${PREFIX}/bin
fi

mv a.out ${PREFIX}/bin/awk
