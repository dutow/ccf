#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

"${DIR}/init-basic.sh"

cd vendor
git submodule add https://github.com/rbock/sqlpp11.git
git submodule add https://github.com/HowardHinnant/date.git
git submodule add https://github.com/rbock/sqlpp11-connector-sqlite3.git
git submodule add https://github.com/LuaDist/libsqlite3.git

git submodule add https://github.com/LuaDist/lua.git
cd lua
git checkout lua-5.3
cd ..
git submodule add https://github.com/jeremyong/Selene.git

git submodule add https://github.com/jeaye/jeayeson.git
git submodule add https://github.com/rjpcomputing/ticpp.git
git submodule add https://github.com/eidheim/Simple-Web-Server.git
git submodule add https://github.com/boostorg/boost.git
git submodule add https://github.com/agauniyal/rang.git
cd boost
git checkout boost-1.62.0
cd ..
git submodule update --init --recursive
cd ..

mkdir bootstrap
cp ${DIR}/build-boost* bootstrap/
