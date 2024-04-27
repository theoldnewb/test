#!/bin/sh


rm -rf sdl/build
mkdir sdl/build
cmake -S sdl/SDL -B sdl/build
cmake --build sdl/build
cmake --install sdl/build --prefix ../tpl



