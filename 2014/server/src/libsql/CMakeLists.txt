cmake_minimum_required(VERSION 2.8)

project(libsql CXX)

# Find source files
file(GLOB SOURCES
	"src/*.cpp"
	"include/*.h"
)

# Include header files
include_directories("include")

# Create shared library
add_library(${PROJECT_NAME} STATIC ${SOURCES})

# Find dependencies
find_package(unofficial-libmysql REQUIRED)
target_link_libraries(${PROJECT_NAME} PRIVATE unofficial::libmysql::libmysql)

find_package(Boost REQUIRED)
include_directories(${Boost_INCLUDE_DIRS})
target_link_libraries(${PROJECT_NAME} PRIVATE ${Boost_LIBRARIES})
