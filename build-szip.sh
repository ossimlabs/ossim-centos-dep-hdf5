#!/bin/bash

cd szip
mkdir -p build
cd build
cmake3 -DCMAKE_BUILD_TYPE=Release ..
make -j 8 install
if [ $? -ne 0 ]; then echo "szip install error: $error" ; exit 1 ; fi
