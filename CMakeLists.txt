cmake_minimum_required(VERSION 3.12)

include(cmake/pico_sdk_import.cmake)
include(cmake/pico_extras_import_optional.cmake)

project(pico_blinky_project C CXX ASM)
set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)

if (PICO_SDK_VERSION_STRING VERSION_LESS "1.3.0")
	message(FATAL_ERROR "Raspberry Pi Pico SDK version 1.3.0 (or later) required. Your version is ${PICO_SDK_VESRION_STRING}")
endif()

# Initialize the SDK
pico_sdk_init()

# Set compile options
add_compile_options(-Wall)
add_executable(blink
	src/main.c
)

# pull in common dependencies
target_link_libraries(blink pico_stdlib)

# create map/bin/hex file etc.
pico_add_extra_outputs(blink)
