
#pragma once

// clang-format breaks clang @...@ macros
// clang-format off

#define CCF_PLATFORM "@CCF_PLATFORM@"
#define CCF_PLATFORM_WINDOWS @CCF_PLATFORM_WINDOWS@
#define CCF_PLATFORM_LINUX @CCF_PLATFORM_LINUX@

#define CCF_ARCH "@CANCELLAR_ARCH@"
#define CCF_ARCH_X86 @CCf_ARCH_X86@
#define CCF_ARCH_X86_32 @CCF_ARCH_X86_32@
#define CCF_ARCH_X86_64 @CCF_ARCH_X86_64@

namespace ccf::compiler_config {
constexpr decltype("@CCF_PLATFORM@") platform() noexcept { return "@CCF_PLATFORM@"; }
constexpr bool platform_windows() noexcept { return @CCF_PLATFORM_WINDOWS@; }
constexpr bool platform_linux() noexcept { return @CCF_PLATFORM_LINUX@; }

constexpr decltype("@CCF_ARCH@") arch() noexcept { return "@CCF_ARCH@"; }
constexpr bool arch_x86() noexcept { return @CCF_ARCH_X86@; }
constexpr bool arch_x86_32() noexcept { return @CCF_ARCH_X86_32@; }
constexpr bool arch_x86_64() noexcept { return @CCF_ARCH_X86_64@; }
}
