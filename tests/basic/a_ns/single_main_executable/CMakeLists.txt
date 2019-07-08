
# This target compiles:
# to avoid an empty object library, we create an empty c++ file in the src folder

ccf_ns("single_main_executable")
ccf_target(EXECUTABLE)
