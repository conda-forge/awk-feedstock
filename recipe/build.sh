#!/bin/bash -euo

set -xe

# If running in Linux or osx-arm64 set the `$HOSTCC` manually
# to avoid calling the hardcoded `cc` command in the makefile
if [[ "${target_platform}" == linux-* || "${target_platform}" == osx-arm64 ]]; then
    make HOSTCC="$CC -g -Wall -pedantic -Wcast-qual"
else
    make
fi

if [ ! -d ${PREFIX}/bin ] ; then
    mkdir -p ${PREFIX}/bin
fi

mv a.out ${PREFIX}/bin/awk
