cmake_minimum_required(VERSION 3.15)
project(simple-test)

set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../../" ${CMAKE_MODULE_PATH})
include(ccf_init)

ccf_3p(catch2 TAG "v2.9.2")

ccf_add_all(NAMESPACE)
