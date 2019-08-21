Cancellar CMake framework
===

This repository provides helpers for setting up C++ projects using CMake in a quick and elegant way.

Howewer, it also makes several assumptions, and will report errors if those aren't met:

* At least CMake 3.16 is used
* The compiler is clang/clang++ (and NOT clang-cl)
* The generator is Ninja
* An out of source build is used

If a project mets these requirements this script allow a zero-configuration setup and offer:

* a sane default configuration (warnings as errors ; most warnings turned on, C++17, ...)
* no global-config-hell: can be used with any classic CMake code, runs fine alongside it
* support for easy configuration of some third parties
* a clang-tidy setup
* a clang-format setup and enforcement
* a standardese setup and automatic documentation generation as part of the build process (only on linux)
* an easy way to add new targets, files and tests
* a python script to make comman tasks even simpler
* environment checks (e.g. installed packages on ubuntu)

Setup:
---

* Add this as a submodule, for example in `cmake/ccf`
* Add that folder to the CMake module path
* `include(ccf_init)` at the start
* `ccf_end()` at the end

Unless otherwise specified, init will automatically add the following third parties:

* For every project:
  * spdlog
  * threads (threading flags)
  * backward-cpp for debug builds (automatic stack trace generation on linux)
* For every test project:
  * catch2
  * fakeit

During its run the script will check for several common configuration files to exists.
If they don't it'll create them based on a template.

These files are:

* `.gitignore`
* `.clang-format`
* git hooks for clang-format
* `.clang-tidy`
* `bt.py`

Optional configuration
---

* `ccf_cpp_extension("cxx")` - reports error if a C++ file uses a different extension
* `ccf_h_extension("hxx", "hpp")` - reports error if a H file uses a non listed extension
* `ccf_tidy_executable(...)` - uses a custom tidy instead of the system one

Third party libraries:
---

For any supported third party in the `3rd-party` forder, add:
`ccf_3p(<name> <TAG|COMMIT> <ref>)` or `ccf_3p(<name> DEFAULT)`

Third party libraries usually expect the sources to be found under `_3p/name`, as a shallow submodule.
It'll ensure that:

* this submodule exists
* that it points to the correct ref
* that the dependency is built with the correct settings if it isn't header only
* that the dependency exists as a CMake interface target

Build structure:
---

These scripts assume a simple module structure, where:

* generic folders are simply "namespaces" for executables/libraries
* folders containing targets follow the following structure:

```
 ns_folder\
   target_folder\
     include\
     internal_include\
     src\
     tests\
       test_executable_1\
         include\
         internal_include\
         src\
         CMakeLists.txt
       test_executable_2\
         ...
       test_library_1\
         include\
         internal_include\
         src\
         CMakeLists.txt
     CMakeLists.txt
   CMakeLists.txt
```

### Adding new targets (full automatic)

* Call `ccf_add_all(NAMESPACE)` in the main CMakeLists
* Create a subdirectory for a namespace: `a_ns`
* Create a subdirectory for an executable: `a_ns/target_folder`
* (Re)run CMake
* Use the newly created executable scaffold in `a_ns/target_folder`

### Adding new targets (manual listing)

* Create the target's directory
* Add the `add_subdirectory` entry to the parent directory
* Add the `ccf_ns`/`ccf_target` call to the CMakeLists.txt in the new directory
* Re-run CMake/Ninja: directories / minimal source files created

### Adding tests

* Add a folder inside `tests`
* Re-run CMake/Ninja: minimal files created

### CMakeLists in ns_folder

```
ccf_ns()
ccf_add_all(TARGET)
```

(created automatically)

### CMakeLists in target_folder

```
ccf_ns()
ccf_target(EXECUTABLE) # or STATIC_LIBRARY/DYNAMIC_LIBRARY
#ccf_depends(some-other-target)
```

(created automatically with EXECUTABLE, without comments)

The build relies on `GLOB_RECURSE` and `CONFIGURE_DEPENDS`, nothing else has to be specified.
The alternative was to add a sanity check to `ccf_end` to check that there are no missing undocumented files - and then this makes more sense.

Executables assume that the `main.cpp` or `main.cxx` file contains the `main` function of the program, and that it doesn't
contain anything else - it is only a starting point.
This is to support writing tests against executables: 
an executable is an object library containing everything but the main, and an executable target using both.
Tests use the object library.

### CMakeLists in a test folder

```
ccf_ns()
ccf_target(EXECUTABLE) # or STATIC_LIBRARY/DYNAMIC_LIBRARY
ccf_test()
#ccf_test(additional_test_name param1 param2 param3)
ccf_depends(catch2)
ccf_depends(parent-target)
```

(created automacitally with EXECUTABLE, without comments)
