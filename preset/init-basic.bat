copy %~dp0\..\assets\gitignore-main .gitignore
copy %~dp0\..\assets\clang-format .clang-format
copy %~dp0\..\assets\CMakeLists.txt CMakeLists.txt
mkdir bin
mkdir build
copy %~dp0\..\assets\gitignore-build build\.gitignore
mkdir vendor
cd vendor
git submodule add https://github.com/easylogging/easyloggingpp.git
git submodule add https://github.com/Microsoft/GSL.git
git submodule add https://github.com/eggs-cpp/variant.git
git submodule add https://github.com/aantron/better-enums.git
git submodule add https://github.com/akrzemi1/Optional.git
git submodule add https://github.com/philsquared/Catch.git
git submodule add https://github.com/eranpeer/FakeIt.git
cd ..