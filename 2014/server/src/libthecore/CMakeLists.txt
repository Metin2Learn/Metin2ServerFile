cmake_minimum_required(VERSION 2.8)

project(libthecore CXX)

# Find source files
file(GLOB SOURCES
	"src/*.cpp"
	"include/*.h"
)

# Include header files
include_directories("include")

# Create shared library
add_library(${PROJECT_NAME} STATIC ${SOURCES})

#
# vcpkg dependencies
#

# Boost
find_package(Boost REQUIRED)
include_directories(${Boost_INCLUDE_DIRS})
target_link_libraries(${PROJECT_NAME} PRIVATE ${Boost_LIBRARIES})

# fmt
find_package(fmt CONFIG REQUIRED)
target_link_libraries(${PROJECT_NAME} PRIVATE fmt::fmt)

# spdlog
find_package(spdlog CONFIG REQUIRED)
target_link_libraries(${PROJECT_NAME} PRIVATE spdlog::spdlog)
