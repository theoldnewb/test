#!/bin/bash

set -e

# SCRIPT is the abs path to the script itself (/home/tom/prj/led/build_generated)
SCRIPT=$(readlink -f "$0")

# SCRIPTPATH is the abs path to the directory of the script (/home/tom/prj/led)
SCRIPTPATH=$(dirname "${SCRIPT}")

echo SCRIPT=${SCRIPT}
echo SCRIPTPATH=${SCRIPTPATH}

rm -rf tmp/
mkdir tmp

cmake -B tmp -S .
cmake --build tmp

