cmake_minimum_required(VERSION 2.8)

project(quest CXX)

file(GLOB_RECURSE sources
  src/*.cc src/*.h
  src/*.c
)

include_directories(src)

# Find dependencies
find_package(Boost REQUIRED)

add_executable(${PROJECT_NAME} ${sources})
set_target_properties(${PROJECT_NAME} PROPERTIES OUTPUT_NAME "qc")

# Link dependencies if found
if (Boost_FOUND)
  include_directories(${Boost_INCLUDE_DIRS})
  target_link_libraries (${PROJECT_NAME} ${Boost_LIBRARIES})
endif (Boost_FOUND)

target_link_libraries(${PROJECT_NAME} liblua)
target_include_directories(${PROJECT_NAME} PUBLIC . ../liblua)