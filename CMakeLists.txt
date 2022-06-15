cmake_minimum_required(VERSION 3.5)

project(ReflexControllersPlugin LANGUAGES CXX)

cmake_policy(SET CMP0012 NEW)

# find OpenSim
#
#  - this is the primary (and only) dependency of the plugin
#
#  - to customize this, set CMAKE_PREFIX_PATH when running the initial 'cmake'
#    configuration step
#
#  - there are other customization options, see:
#
#      https://cmake.org/cmake/help/v3.0/command/find_package.html
if(TRUE)
    find_package(OpenSim
        REQUIRED

        # these PATHS aren't strictly necessary if OpenSim is installed
        # correctly. They are just here as hard-coded guesses
        PATHS
            # Windows (use the most recent one first)
            "C:\\OpenSim 4.4"
            "C:\\OpenSim 4.3"
            "C:\\OpenSim 4.2"
            "C:\\OpenSim 4.1"
            "C:\\OpenSim 3.2"
            "C:\\OpenSim 3.1"
            "C:\\OpenSim 3.0"

            # Mac
            "/Applications/OpenSim 4.4/"
            "/Applications/OpenSim 4.3/"
            "/Applications/OpenSim 4.2/"
            "/Applications/OpenSim 4.1/"
            "/Applications/OpenSim 3.2/"
            "/Applications/OpenSim 3.1/"
            "/Applications/OpenSim 3.0/"
    )

    if(NOT DEFINED OpenSim_ROOT_DIR)
        message(FATAL_ERROR "OpenSim_ROOT_DIR is not defined: this should be defined in the OpenSim cmake configuration for this plugin to be installable")
    endif()

    if(NOT DEFINED OpenSim_LIB_DIR)
        message(FATAL_ERROR "OpenSim_LIB_DIR is not defined: this should be defined in the OpenSim cmake configuration for this plugin to be installable")
    endif()
endif()

add_library(ReflexControllersPlugin SHARED
    src/DelayedPathReflexController.cpp
    src/DelayedPathReflexController.h
    src/MuscleFiberStretchController.cpp
    src/MuscleFiberStretchController.h
    src/MusclePathStretchController.h
    src/MusclePathStretchController.cpp
    src/ReflexController.h
    src/ReflexController.cpp

    # exports plugin API
    src/RegisterTypes_osimPlugin.h
    src/RegisterTypes_osimPlugin.cpp
    src/osimReflexesDLL.h
)
target_link_libraries(ReflexControllersPlugin PUBLIC
    osimCommon
    osimSimulation
    osimActuators
    osimAnalyses
    osimTools
    osimLepton
    SimTKcommon
    SimTKmath
    SimTKsimbody
)
set_target_properties(ReflexControllersPlugin PROPERTIES
    DEFINE_SYMBOL OSIMREFLEXES_EXPORTS
    PROJECT_LABEL "Libraries - ReflexControllerPlugin"
)
target_compile_features(ReflexControllersPlugin PUBLIC cxx_std_11)

# if the developer runs 'install', then install the plugin into OpenSim's plugin
# dir
install(
    TARGETS ReflexControllersPlugin

    # where .exe and .dll (Windows) files go
    RUNTIME DESTINATION ${OpenSim_ROOT_DIR}/plugins

    # where .so (Linux) and .dylib (Mac) go
    LIBRARY DESTINATION ${OpenSim_ROOT_DIR}/plugins

    # where static libs (.a) and .lib (Windows) go
    ARCHIVE DESTINATION ${OpenSim_LIB_DIR}
)

