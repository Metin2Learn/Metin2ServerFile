cmake_minimum_required(VERSION 2.8)

project(libgame CXX)

# Find source files
file(GLOB SOURCES
	"src/*.cc"
	"include/*.h"
)

# Include header files
include_directories("include")

find_package(Boost REQUIRED)

# Create shared library
add_library(${PROJECT_NAME} STATIC ${SOURCES})

if (Boost_FOUND)
  include_directories(${Boost_INCLUDE_DIRS})
  target_link_libraries (${PROJECT_NAME} ${Boost_LIBRARIES})
endif (Boost_FOUND)