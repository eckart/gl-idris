OpenGL for Idris
================

This project contains low-level bindings for the OpenGL graphics system.

It comes with some bells and whistles:

* An OBJ-Loader for loading 3D-Models
* PNG-Texure Loading
* Utilities for creating view / perspective / transformation matrices
* a few convenience functions for shader initialisation, model to gpu transfer etc.
* Effects (upcoming)

Currently this project only provides OpenGL version 4.1 because I'm on a mac, and version only 4.1 is provided.

The low-level bindings are generated from the [OpenGL API Registry](https://cvs.khronos.org/svn/repos/ogl/trunk/doc/registry/public/api/gl.xml). Currently the generator is too stupid to handle all the cases so there
are still some commands missing.


Requirements
------------

* [OpenGL](https://www.opengl.org/) OpenGL itself.
* [GLEW](http://glew.sourceforge.net/) OpenGL initialisation and extension loading
* pkg-config for providing the include and lib flags to the compiler
* [Idris](http://www.idris-lang.org/) at least version 0.9.18
* [Lightyear](https://github.com/ziman/lightyear) for OBJ file parsing
* [libpng](http://www.libpng.org) for texture loading

Installation
------------

Please follow the individual installation instructions for each of the required components.

If you are on a mac you can get away with `brew install` for GLEW, pkg-config and libpng.
OpenGL is already installed.

This project contains a small C file for easier integration.
The Makefile for the FFI is platform dependent and will currently work only on MacOS:

Specifically it says in `src/MakefileGl'
```make
echo "%flag C \"-framework OpenGL\"" >> Graphics/Rendering/Config.idr

```

You might need to change `-framework OpenGL` to whatever is needed for the C flags on your system.


How to use it
-------------

There are two examples in the `example` folder.
To run these examples you need to install more libraries, since OpenGL provides
no means to open a window or process user input.

The first examples uses GLFW while the second uses SDL2

For the GLFW example you need an additional Idris libray found here: https://github.com/eckart/glfw-idris
For the SDL2 example you obviously also need an additional library: https://github.com/eckart/SDL2-idris


Is is safe to use it yet?
-------------------------

I primarily did all this because I wanted to lear Idris and thought I'd do it by drawing things.
Right now I am still on working on it, so it is not abandoned.

It might even be stable enough even if lots of things are still missing.

The real low-level stuff sits in the module `Graphics.Rendering.Gl.Gl41.id` which is a fairly
direct translation of the OpenGL stuff except for the enums, which I have tried to group into data types.
I'm still not clear whether this was a good idea or not.
However I have no plans to change any of that stuff any time soon.

Is it safe to use it? I don't know..




