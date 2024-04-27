cmake_minimum_required(VERSION 3.29.2)
#set(CMAKE_VERBOSE_MAKEFILE ON)
include(CheckFunctionExists)

project(sdl)

message(STATUS "CMAKE_SYSTEM_PROCESSOR=${CMAKE_SYSTEM_PROCESSOR}")

set(CMAKE_PREFIX_PATH tpl/)
find_package(SDL3 REQUIRED CONFIG REQUIRED COMPONENTS SDL3-shared)
find_package(VulkanHeaders REQUIRED CONFIG)
find_package(VulkanLoader REQUIRED CONFIG REQUIRED COMPONENTS VulkanLoader-shared)

message(STATUS "SDL3 Header Version: ${SDL3_VERSION}")
message(STATUS "Vulkan Headers Version: ${VulkanHeaders_VERSION}")
message(STATUS "Vulkan Loader Version: ${VulkanLoader_VERSION}")
message(STATUS "CGLM Found: ${cglm_FOUND}")


add_compile_definitions(_DEBUG)
add_compile_definitions(CGLM_FORCE_DEPTH_ZERO_TO_ONE)
add_compile_definitions(CGLM_FORCE_LEFT_HANDED)
 
if(LINUX)
    add_compile_options(-O0)
    add_compile_options(-ggdb)
    add_compile_options(-Wfatal-errors)
    add_compile_options(-Wall)
    add_compile_options(-fno-omit-frame-pointer)
    add_compile_options(-fvisibility=hidden)
endif()

set(PROJECT_SOURCES
    src/main.c
    src/sdl.c
    src/sdl.h
)

add_executable(${PROJECT_NAME} ${PROJECT_SOURCES})

set_target_properties(${PROJECT_NAME} PROPERTIES
                      RUNTIME_OUTPUT_DIRECTORY ..
#                      RUNTIME_OUTPUT_DIRECTORY_DEBUG ../
#                      RUNTIME_OUTPUT_DIRECTORY_RELEASE ../
)

target_link_libraries(${PROJECT_NAME} 
    PRIVATE Vulkan::Headers
    PRIVATE SDL3::SDL3
    PRIVATE Vulkan::Loader
)

if(NOT POW_FUNCTION_EXISTS AND NOT NEED_LINKING_AGAINST_LIBM)
  CHECK_FUNCTION_EXISTS(pow POW_FUNCTION_EXISTS)
  if(NOT POW_FUNCTION_EXISTS)
      unset(POW_FUNCTION_EXISTS CACHE)
      list(APPEND CMAKE_REQUIRED_LIBRARIES m)
      CHECK_FUNCTION_EXISTS(pow POW_FUNCTION_EXISTS)
      if(POW_FUNCTION_EXISTS)
          set(NEED_LINKING_AGAINST_LIBM True CACHE BOOL "" FORCE)
      else()
          message(FATAL_ERROR "Failed making the pow() function available")
      endif()
  endif()
endif()

if (NEED_LINKING_AGAINST_LIBM)
     target_link_libraries(${PROJECT_NAME} PRIVATE m)
endif()


