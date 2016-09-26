
#pragma once

// clang-format breaks clang @...@ macros
// clang-format off

#define CANCELLAR_PLATFORM "@CANCELLAR_PLATFORM@"
#define CANCELLAR_PLATFORM_WINDOWS @CANCELLAR_PLATFORM_WINDOWS@
#define CANCELLAR_PLATFORM_LINUX @CANCELLAR_PLATFORM_LINUX@

#define CANCELLAR_ARCH "@CANCELLAR_ARCH@"
#define CANCELLAR_ARCH_X86 @CANCELLAR_ARCH_X86@
#define CANCELLAR_ARCH_X86_32 @CANCELLAR_ARCH_X86_32@
#define CANCELLAR_ARCH_X86_64 @CANCELLAR_ARCH_X86_64@

namespace cancellar::compiler_config {
constexpr decltype("@CANCELLAR_PLATFORM@") platform() { return "@CANCELLAR_PLATFORM@"; }
constexpr bool platform_windows() { return @CANCELLAR_PLATFORM_WINDOWS@; }
constexpr bool platform_linux() { return @CANCELLAR_PLATFORM_LINUX@; }

constexpr decltype("@CANCELLAR_ARCH@") arch() { return "@CANCELLAR_ARCH@"; }
constexpr bool arch_x86() { return @CANCELLAR_ARCH_X86@; }
constexpr bool arch_x86_32() { return @CANCELLAR_ARCH_X86_32@; }
constexpr bool arch_x86_64() { return @CANCELLAR_ARCH_X86_64@; }
}
