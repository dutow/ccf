#!/bin/bash

CURR=`pwd`

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd "${DIR}/../vendor/"

mkdir boost-install

cd boost

./bootstrap.sh --with-toolset=clang
./b2 headers --ignore-site-config 
./b2 install toolset=clang link=static runtime-link=shared threading=multi --prefix=../boost-install/ --with-filesystem --with-system --with-fiber --with-thread --ignore-site-config --with-date_time --with-iostreams --with-atomic --with-context --with-program_options cxxflags=-std=gnu++1z

cd "$CURR"
