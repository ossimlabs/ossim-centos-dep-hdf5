#!/bin/bash

cd hdf5
mkdir -p build
cd build
cmake3 \
  -DCMAKE_INSTALL_PREFIX=/usr/local \
  -DSZIP_LIBRARY=/usr/local/lib/libszip.a \
  -DSZIP_INCLUDE_DIR=/usr/local/include \
  -DSZIP_DIR=/usr/local \
  -DBUILD_TESTING=OFF \
  -DCMAKE_BUILD_TYPE=Release \
  -DHDF5_BUILD_CPP_LIB=ON \
  -DHDF5_BUILD_EXAMPLES=OFF \
  -DHDF5_BUILD_FORTRAN=OFF \
  -DHDF5_BUILD_HL_LIB=OFF \
  -DHDF5_BUILD_TOOLS=OFF \
  -DHDF5_ENABLE_Z_LIB_SUPPORT=ON \
  -DHDF5_ENABLE_SZIP_SUPPORT=ON \
  ..

make VERBOSE=1 -j 8 install
if [ $? -ne 0 ]; then echo "hdf5 make install error: $error" ; exit 1 ; fi
