#!/bin/sh


# SDL

rm -rf build
mkdir build
cmake -S SDL -B build
cmake --build build
cmake --install build --prefix ../tpl

# cglm

rm -rf build
mkdir build
cmake -S cglm -B build
cmake --build build
cmake --install build --prefix ../tpl

# vulkan headers

rm -rf build
mkdir build
cmake -S Vulkan-Headers -B build
cmake --build build
cmake --install build --prefix ../tpl

# vulkan loader

rm -rf build
mkdir build
cmake -S Vulkan-Loader -B build
cmake --build build
cmake --install build --prefix ../tpl



