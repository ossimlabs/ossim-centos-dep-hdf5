#!/bin/bash

set -e

HDF5="hdf5-1.10.5"


if [ ! -d "${dir}" ]; then
    wget -q https://s3.amazonaws.com/ossimlabs/dependencies/source/$HDF5.tgz -O $HDF5.tgz
    tar xvfz $HDF5.tgz
    rm -f $HDF5.tgz
    mv "${HDF5}" "hdf5"
fi
