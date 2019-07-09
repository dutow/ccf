
#include "foo_include.h"

#include "deep.hxx"
#include "shared.hxx"
#include "st_foo.hxx"
#include <iostream>


void foo() {
  std::cout << "Hello world: " << st_foo() << ", " << deep() << ", "
            << shared_function() << "!";
}
