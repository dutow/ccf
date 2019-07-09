
# This target compiles: everything is correctly set

ccf_ns(an_executable)
ccf_target(EXECUTABLE)
ccf_depends(a_ns-a_static_library a_ns-a_shared_library)
