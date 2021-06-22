# opensim-reflex-controllers

> An OpenSim plugin creating various reflex-like controllers for muscles

Supported reflexes include:

1. Path Stretch Reflexes (length and velocity)
2. Fiber Stretch Reflexes (length and velocity)
3. Delayed stretch reflexes (constant time offset)


# Building

Dependencies:

- A standard C/C++ compiler (clang, MSVC, gcc)
- CMake
- OpenSim ([binaries](https://simtk.org/home/opensim), [source](https://github.com/opensim-org/opensim-core))
- (I built this against OpenSim4.2)

Build Scripts:

(read these if you know what you are doing)

| OS | Build Script |
| - | - |
| OSX | scripts/build_osx-catalina.sh |


# Running

Once you have built the library, you will can use it at the command line
(`opensim-cmd`) like:

```bash
opensim-cmd -L /path/to/library.so <cmd>
```

Or in the GUI, which has some platform-dependent steps:

- Windows: copy the library into the `plugins/` directory in your OpenSim
  install directory (e.g. `C:\OpenSim 4.2\plugins`). Make the `plugins/`
  directory if it doesn't already exist. Once you copy it there, boot up the
  GUI. You should be able to see the plugin in `Tools > User Plugins`

- Mac/Linux: boot up the GUI and use the ScriptingShell to load the plugin. Open
  the ScriptingShell tab (near the bottom) and type the path to the library
  **without the file suffix (e.g. .dylib)**:

```
modeling.Model.LoadOpenSimLibrary("/path/to/library")

# e.g. modeling.Model.LoadOpenSimLibrary("/Applications/OpenSim 4.2/plugins/libReflexControllersPlugin")
```

- Mac/Linux (cont.): any loading errors will appear in the (separate) `Messages`
  tab. Check there if there's a problem

