#!/bin/bash

set -e

HDF5="hdf5-${HDF5_VERSION}"
dir="${DEPS_DIR}/hdf5"

if [ ! -d "${dir}" ]; then
    wget -q https://s3.amazonaws.com/ossimlabs/dependencies/source/$HDF5.tgz -O $HDF5.tgz
    tar xvfz $HDF5.tgz
    rm -f $HDF5.tgz
    mv "${HDF5}" "${DEPS_DIR}/hdf5"
fi
