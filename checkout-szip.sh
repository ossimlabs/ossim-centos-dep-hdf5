#!/bin/bash

set -e

SZIP="szip-2.1.1"


if [ ! -d "${dir}" ]; then
    wget -q https://s3.amazonaws.com/ossimlabs/dependencies/source/$SZIP.tgz -O $SZIP.tgz
    tar xvfz $SZIP.tgz
    rm -f $SZIP.tgz
    mv "${SZIP}" "szip"
fi
