#!/usr/bin/env bash

set -xeuo pipefail

# make the build directory
mkdir -p build/
cd build/

# configure the project
#
# if this step fails to find OpenSim, then you can add
# -DCMAKE_PREFIX_PATH=OPENSIM_INSTALL_PATH to this command to give CMake a hint
# about where to search for it
cmake ..  #-DCMAKE_PREFIX_PATH=/some/custom/path/to/OpenSim

# build the project
cmake --build .

# (optional) install it into the OpenSim plugins/ dir
#
# mkdir -p /Applications/OpenSim 4.2/plugins
# cp ReflexControllersPlugin /Applications/OpenSim 4.2/plugins
