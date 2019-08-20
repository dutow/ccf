cmake_minimum_required(VERSION 3.15)
project(simple-test)

set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../../" ${CMAKE_MODULE_PATH})
set(CCF_DEP_STRATEGY submodule) # clone
include(ccf_init)
ccf_dep(catch2 "v2.9.2")


add_subdirectory(a_ns)
