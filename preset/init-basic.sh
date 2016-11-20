#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cp "${DIR}/../assets/gitignore-main" .gitignore
cp "${DIR}/../assets/clang-format" .clang-format
cp "${DIR}/../assets/CMakeLists.txt" CMakeLists.txt
mkdir bin
mkdir build
cp "${DIR}/../assets/gitignore-build" build/.gitignore
mkdir vendor
cd vendor
git submodule add https://github.com/easylogging/easyloggingpp.git
git submodule add https://github.com/Microsoft/GSL.git
git submodule add https://github.com/eggs-cpp/variant.git
git submodule add https://github.com/aantron/better-enums.git
git submodule add https://github.com/akrzemi1/Optional.git
git submodule add https://github.com/philsquared/Catch.git
git submodule add https://github.com/eranpeer/FakeIt.git
git submodule add https://github.com/ericniebler/range-v3.git
git submodule add https://github.com/jeaye/jeayeson.git
cd ..
